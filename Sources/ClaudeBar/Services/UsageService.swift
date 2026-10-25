import Foundation

final class UsageService {
    private let network: NetworkService
    private var cachedOrgUUID: String? {
        get { UserDefaults.standard.string(forKey: "cachedOrgUUID") }
        set { UserDefaults.standard.set(newValue, forKey: "cachedOrgUUID") }
    }
    private var cachedUsage: UsageData?
    private var cacheExpiry: Date?

    init(network: NetworkService) {
        self.network = network
    }

    func fetch(forceRefresh: Bool = false) async throws -> UsageData {
        if !forceRefresh, let cached = cachedUsage, let expiry = cacheExpiry, Date() < expiry {
            return cached
        }

        let orgUUID = try await resolveOrgUUID()
        let response = try await network.get(
            "https://claude.ai/api/organizations/\(orgUUID)/usage",
            as: UsageAPIResponse.self
        )
        let data = response.toDomain()
        cachedUsage = data
        cacheExpiry = Date().addingTimeInterval(55)
        return data
    }

    func fetchPlanTier() async throws -> PlanTier? {
        let orgs = try await network.get(
            "https://claude.ai/api/organizations",
            as: OrganizationsResponse.self
        )
        let org = orgs.organizations.first(where: { $0.uuid != nil && $0.uuid == cachedOrgUUID })
            ?? orgs.organizations.first
        guard let org else { return nil }
        return PlanTier(rateLimitTier: org.rateLimitTier, capabilities: org.capabilities)
    }

    private func resolveOrgUUID() async throws -> String {
        if let cached = cachedOrgUUID { return cached }

        let orgs = try await network.get(
            "https://claude.ai/api/organizations",
            as: OrganizationsResponse.self
        )
        guard let uuid = orgs.firstUUID else {
            throw AppError.organizationNotFound
        }
        cachedOrgUUID = uuid
        return uuid
    }
}
