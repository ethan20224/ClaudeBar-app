import Foundation

enum SafariCookieReader {
    private static let cookiePath = NSString(string: "~/Library/Cookies/Cookies.binarycookies")
        .expandingTildeInPath

    static func extractSessionKey() -> String? {
        guard FileManager.default.fileExists(atPath: cookiePath),
              let data = try? Data(contentsOf: URL(fileURLWithPath: cookiePath)) else {
            return nil
        }
        return parse(data).first(where: {
            $0.domain.hasSuffix("claude.ai") && $0.name == "sessionKey"
        })?.value
    }

    private static func parse(_ data: Data) -> [Cookie] {
        guard data.count >= 8,
              String(data: data.prefix(4), encoding: .ascii) == "cook" else { return [] }

        let numPages = Int(readUInt32(data, at: 4, bigEndian: true))
        var offset = 8
        var pageSizes: [Int] = []
        for _ in 0..<numPages {
            pageSizes.append(Int(readUInt32(data, at: offset, bigEndian: true)))
            offset += 4
        }

        var cookies: [Cookie] = []
        for size in pageSizes {
            guard offset + size <= data.count else { break }
            cookies.append(contentsOf: parsePage(data.subdata(in: offset..<offset + size)))
            offset += size
        }
        return cookies
    }

    private static func parsePage(_ page: Data) -> [Cookie] {
        guard page.count >= 8,
              readUInt32(page, at: 0, bigEndian: true) == 0x00000100 else { return [] }

        let numCookies = Int(readUInt32(page, at: 4, littleEndian: true))
        var off = 8
        var offsets: [Int] = []
        for _ in 0..<numCookies {
            offsets.append(Int(readUInt32(page, at: off, littleEndian: true)))
            off += 4
        }

        var cookies: [Cookie] = []
        for cookieOffset in offsets {
            guard cookieOffset + 44 <= page.count else { continue }

            let recordSize = Int(readUInt32(page, at: cookieOffset, littleEndian: true))
            guard cookieOffset + recordSize <= page.count else { continue }

            let flags = readUInt32(page, at: cookieOffset + 8, littleEndian: true)
            let urlOff    = Int(readUInt32(page, at: cookieOffset + 16, littleEndian: true))
            let nameOff   = Int(readUInt32(page, at: cookieOffset + 20, littleEndian: true))
            let pathOff   = Int(readUInt32(page, at: cookieOffset + 24, littleEndian: true))
            let valueOff  = Int(readUInt32(page, at: cookieOffset + 28, littleEndian: true))

            let expiry = Double(bitPattern: readUInt64(page, at: cookieOffset + 36))

            let url   = cString(page, from: cookieOffset + urlOff)
            let name  = cString(page, from: cookieOffset + nameOff)
            let value = cString(page, from: cookieOffset + valueOff)

            guard let name, let value, let url else { continue }

            var domain = url
            if let schemeEnd = domain.range(of: "://") {
                domain = String(domain[schemeEnd.upperBound...])
            }
            if let slash = domain.firstIndex(of: "/") {
                domain = String(domain[..<slash])
            }

            cookies.append(Cookie(
                name: name,
                value: value,
                domain: domain,
                path: cString(page, from: cookieOffset + pathOff) ?? "/",
                expiry: expiry > 0 ? Date(timeIntervalSinceReferenceDate: expiry) : nil,
                isSecure: (flags & 1) != 0,
                isHttpOnly: (flags & 4) != 0
            ))
        }
        return cookies
    }

    private static func cString(_ data: Data, from offset: Int) -> String? {
        guard offset >= 0, offset < data.count else { return nil }
        let slice = data[offset...]
        guard let terminator = slice.firstIndex(of: 0) else { return nil }
        return String(data: slice[..<terminator], encoding: .utf8)
    }

    private static func readUInt32(_ data: Data, at offset: Int, bigEndian: Bool) -> UInt32 {
        let raw = data.withUnsafeBytes { $0.loadUnaligned(fromByteOffset: offset, as: UInt32.self) }
        return bigEndian ? raw.bigEndian : raw
    }

    private static func readUInt32(_ data: Data, at offset: Int, littleEndian: Bool) -> UInt32 {
        let raw = data.withUnsafeBytes { $0.loadUnaligned(fromByteOffset: offset, as: UInt32.self) }
        return littleEndian ? raw : raw.bigEndian
    }

    private static func readUInt64(_ data: Data, at offset: Int) -> UInt64 {
        data.withUnsafeBytes { $0.loadUnaligned(fromByteOffset: offset, as: UInt64.self) }
    }

    private struct Cookie {
        let name: String
        let value: String
        let domain: String
        let path: String
        let expiry: Date?
        let isSecure: Bool
        let isHttpOnly: Bool
    }
}
