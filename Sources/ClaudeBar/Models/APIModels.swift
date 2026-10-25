import Foundation

struct UsageAPIResponse: Decodable {
    let fiveHour: PeriodResponse
    let sevenDay: PeriodResponse

    struct PeriodResponse: Decodable {
        let utilization: Double
        let resetsAt: Date?

        enum CodingKeys: String, CodingKey {
            case utilization
            case resetsAt = "resets_at"
        }
    }

    enum CodingKeys: String, CodingKey {
        case fiveHour = "five_hour"
        case sevenDay = "seven_day"
    }

    func toDomain() -> UsageData {
        UsageData(
            fiveHour: UsagePeriod(utilization: fiveHour.utilization, resetsAt: fiveHour.resetsAt, periodSeconds: 5 * 3600),
            sevenDay: UsagePeriod(utilization: sevenDay.utilization, resetsAt: sevenDay.resetsAt, periodSeconds: 7 * 24 * 3600),
            fetchedAt: Date()
        )
    }
}

struct OrganizationsResponse: Decodable {
    let organizations: [OrgItem]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var orgs: [OrgItem] = []
        while !container.isAtEnd {
            orgs.append(try container.decode(OrgItem.self))
        }
        self.organizations = orgs
    }

    struct OrgItem: Decodable {
        let uuid: String?
        let id: Int?
        let name: String?
        let rateLimitTier: String?
        let capabilities: [String]?

        enum CodingKeys: String, CodingKey {
            case uuid, id, name, capabilities
            case rateLimitTier = "rate_limit_tier"
        }

        init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)
            uuid = try c.decodeIfPresent(String.self, forKey: .uuid)
            id = try c.decodeIfPresent(Int.self, forKey: .id)
            name = try c.decodeIfPresent(String.self, forKey: .name)
            // Plan fields are best effort: a surprise in their shape must never break usage fetching.
            rateLimitTier = (try? c.decodeIfPresent(String.self, forKey: .rateLimitTier)) ?? nil
            capabilities = (try? c.decodeIfPresent([String].self, forKey: .capabilities)) ?? nil
        }
    }

    var firstUUID: String? {
        organizations.first?.uuid
    }
}
