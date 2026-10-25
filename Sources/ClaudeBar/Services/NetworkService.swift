import Foundation

final class NetworkService {
    private let sessionKey: String
    private let session: URLSession

    init(sessionKey: String) {
        self.sessionKey = sessionKey
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        self.session = URLSession(configuration: config)
    }

    func get<T: Decodable>(_ urlString: String, as type: T.Type) async throws -> T {
        guard urlString.hasPrefix("https://"),
              let url = URL(string: urlString) else {
            throw AppError.networkError("Invalid URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("sessionKey=\(sessionKey)", forHTTPHeaderField: "Cookie")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
            forHTTPHeaderField: "User-Agent"
        )
        request.setValue("https://claude.ai", forHTTPHeaderField: "Referer")
        request.setValue("https://claude.ai", forHTTPHeaderField: "Origin")
        request.setValue("same-origin", forHTTPHeaderField: "Sec-Fetch-Site")
        request.setValue("cors", forHTTPHeaderField: "Sec-Fetch-Mode")
        request.setValue("empty", forHTTPHeaderField: "Sec-Fetch-Dest")

        let (data, response) = try await withRetry(maxAttempts: 3) {
            try await self.session.data(for: request)
        }

        guard let http = response as? HTTPURLResponse else {
            throw AppError.networkError("Invalid response")
        }

        switch http.statusCode {
        case 200...299:
            break
        case 401, 403:
            throw AppError.authenticationFailed
        default:
            throw AppError.networkError("HTTP \(http.statusCode)")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)
            let formatters: [ISO8601DateFormatter] = [
                {
                    let f = ISO8601DateFormatter()
                    f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                    return f
                }(),
                {
                    let f = ISO8601DateFormatter()
                    f.formatOptions = [.withInternetDateTime]
                    return f
                }()
            ]
            for formatter in formatters {
                if let date = formatter.date(from: string) { return date }
            }
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot parse date: \(string)")
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw AppError.decodingError(error.localizedDescription)
        }
    }
}

private func withRetry<T>(maxAttempts: Int, operation: () async throws -> T) async throws -> T {
    var lastError: Error?
    for attempt in 0..<maxAttempts {
        do {
            return try await operation()
        } catch let e as AppError {
            if case .authenticationFailed = e { throw e }
            lastError = e
        } catch {
            lastError = error
        }
        if attempt < maxAttempts - 1 {
            let delay = pow(2.0, Double(attempt))
            try? await Task.sleep(for: .seconds(delay))
        }
    }
    throw lastError ?? AppError.networkError("Unknown error")
}
