import Foundation
import CommonCrypto
import CSQLite3
import CryptoKit

enum ChromeCookieReader {
    private struct BrowserProfile {
        let name: String
        let cookiePath: String
        let keychainService: String
        let keychainAccount: String
    }

    private static let profiles: [BrowserProfile] = [
        BrowserProfile(name: "Claude",
                       cookiePath: "~/Library/Application Support/Claude/Cookies",
                       keychainService: "Claude Safe Storage",
                       keychainAccount: "Claude Key"),
        BrowserProfile(name: "Chrome",
                       cookiePath: "~/Library/Application Support/Google/Chrome/Default/Cookies",
                       keychainService: "Chrome Safe Storage",
                       keychainAccount: "Chrome"),
        BrowserProfile(name: "Brave",
                       cookiePath: "~/Library/Application Support/BraveSoftware/Brave-Browser/Default/Cookies",
                       keychainService: "Chrome Safe Storage",
                       keychainAccount: "Chrome"),
        BrowserProfile(name: "Edge",
                       cookiePath: "~/Library/Application Support/Microsoft Edge/Default/Cookies",
                       keychainService: "Chrome Safe Storage",
                       keychainAccount: "Chrome"),
        BrowserProfile(name: "Arc",
                       cookiePath: "~/Library/Application Support/Arc/User Data/Default/Cookies",
                       keychainService: "Chrome Safe Storage",
                       keychainAccount: "Chrome"),
    ]

    static func extractSessionKey() -> String? {
        for profile in profiles {
            let fullPath = NSString(string: profile.cookiePath).expandingTildeInPath
            guard FileManager.default.fileExists(atPath: fullPath) else { continue }
            if let key = tryExtract(dbPath: fullPath, profile: profile) { return key }
        }
        return nil
    }

    private static func tryExtract(dbPath: String, profile: BrowserProfile) -> String? {
        if let encrypted = readEncryptedValue(from: dbPath), let decrypted = decrypt(encrypted, profile: profile) {
            return decrypted
        }
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent("cb_cookies_\(UUID().uuidString)")
        defer { try? FileManager.default.removeItem(at: tempURL) }
        guard let _ = try? FileManager.default.copyItem(atPath: dbPath, toPath: tempURL.path),
              let encrypted = readEncryptedValue(from: tempURL.path),
              let decrypted = decrypt(encrypted, profile: profile) else {
            return nil
        }
        return decrypted
    }

    private static func readEncryptedValue(from dbPath: String) -> Data? {
        var db: OpaquePointer?
        guard sqlite3_open_v2(dbPath, &db, SQLITE_OPEN_READONLY, nil) == SQLITE_OK else { return nil }
        defer { sqlite3_close(db) }

        var stmt: OpaquePointer?
        let sql = """
            SELECT encrypted_value FROM cookies
            WHERE host_key LIKE '%claude.ai' AND name = 'sessionKey'
            ORDER BY creation_utc DESC LIMIT 1
            """
        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else { return nil }
        defer { sqlite3_finalize(stmt) }

        guard sqlite3_step(stmt) == SQLITE_ROW else { return nil }
        guard let blob = sqlite3_column_blob(stmt, 0) else { return nil }
        let len = Int(sqlite3_column_bytes(stmt, 0))
        guard len > 3 else { return nil }

        return Data(bytes: blob, count: len)
    }

    private static func decrypt(_ data: Data, profile: BrowserProfile) -> String? {
        guard data.count > 3,
              let prefix = String(data: data.prefix(3), encoding: .utf8),
              let keyData = encryptionKey(for: profile) else { return nil }

        switch prefix {
        case "v10": return decryptV10(data: data, key: keyData)
        case "v20": return decryptV20(data: data, key: keyData)
        default:    return nil
        }
    }

    private static func encryptionKey(for profile: BrowserProfile) -> Data? {
        // Keychain direct read
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: profile.keychainService,
            kSecAttrAccount: profile.keychainAccount,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne,
        ]
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) == errSecSuccess,
           let rawData = item as? Data {
            if let key = Data(base64Encoded: rawData) { return key }
            return rawData
        }

        // Fallback: security CLI
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/security")
        task.arguments = ["find-generic-password", "-w", "-s", profile.keychainService, "-a", profile.keychainAccount]
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = FileHandle.nullDevice
        try? task.run()
        task.waitUntilExit()
        let output = pipe.fileHandleForReading.readDataToEndOfFile()
        guard task.terminationStatus == 0, !output.isEmpty else { return nil }
        let b64String = String(data: output, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        return Data(base64Encoded: b64String)
    }

    private static func decryptV10(data: Data, key: Data) -> String? {
        guard data.count > 19 else { return nil }
        let iv = data.subdata(in: 3..<19)
        let ciphertext = data.subdata(in: 19..<data.count)

        var outLen = 0
        var buffer = Data(count: ciphertext.count + kCCBlockSizeAES128)
        let bufferCount = buffer.count
        let cipherLen = ciphertext.count

        let status = buffer.withUnsafeMutableBytes { outPtr in
            ciphertext.withUnsafeBytes { cipherPtr in
                iv.withUnsafeBytes { ivPtr in
                    key.withUnsafeBytes { keyPtr in
                        CCCrypt(
                            CCOperation(kCCDecrypt),
                            CCAlgorithm(kCCAlgorithmAES),
                            CCOptions(kCCOptionPKCS7Padding),
                            keyPtr.baseAddress, kCCKeySizeAES128,
                            ivPtr.baseAddress,
                            cipherPtr.baseAddress, cipherLen,
                            outPtr.baseAddress, bufferCount,
                            &outLen
                        )
                    }
                }
            }
        }

        guard status == kCCSuccess else { return nil }
        return String(data: buffer.prefix(outLen), encoding: .utf8)
    }

    private static func decryptV20(data: Data, key: Data) -> String? {
        guard data.count > 15 + 16 else { return nil }
        let iv = data.subdata(in: 3..<15)
        let ciphertextWithTag = data.subdata(in: 15..<data.count)
        guard ciphertextWithTag.count >= 16 else { return nil }

        let tagEnd = ciphertextWithTag.count
        let tag = ciphertextWithTag.subdata(in: tagEnd - 16..<tagEnd)
        let ciphertext = ciphertextWithTag.subdata(in: 0..<tagEnd - 16)

        guard let nonce = try? AES.GCM.Nonce(data: iv),
              let box = try? AES.GCM.SealedBox(nonce: nonce, ciphertext: ciphertext, tag: tag),
              let decrypted = try? AES.GCM.open(box, using: SymmetricKey(data: key)) else {
            return nil
        }
        return String(data: decrypted, encoding: .utf8)
    }
}
