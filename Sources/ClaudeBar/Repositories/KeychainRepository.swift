import Foundation
import Security

final class KeychainRepository {
    private let service: String
    private let account = "sessionKey"

    /// A developer build (no bundle id) keeps the original name. The packaged app uses its own
    /// bundle id, so it never shares, overwrites or deletes a developer build's item.
    init(bundleID: String? = Bundle.main.bundleIdentifier) {
        service = Self.serviceName(bundleID: bundleID)
    }

    static func serviceName(bundleID: String?) -> String {
        guard let bundleID, !bundleID.isEmpty else { return "com.claudebar" }
        return bundleID
    }

    func save(sessionKey: String) throws {
        guard let data = sessionKey.data(using: .utf8) else {
            throw AppError.keychainError("Failed to encode key")
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]

        let updateAttrs: [String: Any] = [kSecValueData as String: data]
        let updateStatus = SecItemUpdate(query as CFDictionary, updateAttrs as CFDictionary)

        if updateStatus == errSecItemNotFound {
            var addQuery = query
            addQuery[kSecValueData as String] = data
            addQuery[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlock
            let addStatus = SecItemAdd(addQuery as CFDictionary, nil)
            guard addStatus == errSecSuccess else {
                throw AppError.keychainError("Failed to save: \(addStatus)")
            }
        } else if updateStatus != errSecSuccess {
            throw AppError.keychainError("Failed to update: \(updateStatus)")
        }
    }

    func load() throws -> String {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess,
              let data = item as? Data,
              let key = String(data: data, encoding: .utf8) else {
            throw AppError.keychainError("Session key not found")
        }
        return key
    }

    func hasKey() -> Bool {
        (try? load()) != nil
    }

    func delete() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(query as CFDictionary)
    }
}
