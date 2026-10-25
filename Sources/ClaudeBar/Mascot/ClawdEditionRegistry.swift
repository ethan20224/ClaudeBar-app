import Foundation

enum ClawdEditions {
    /// Every edition, in shelf order. Hand-made editions first, then each authored batch.
    /// Set to false to ship without editions based on real franchises, brands and characters.
    /// They are for personal use until licensed or replaced.
    static let includeTrademarked = true

    static let all: [ClawdEdition] = (core + franchise + franchise2 + franchise3
        + batch1 + batch2 + batch3 + batch4 + batch5 + batch6 + batch7 + batch8
        + batch9 + batch10 + batch11 + batch12 + batch13
        + batch14 + batch15 + batch16 + batch17).filter { includeTrademarked || !$0.trademarked }

    private static let index: [String: ClawdEdition] = Dictionary(all.map { ($0.id, $0) }, uniquingKeysWith: { first, _ in first })

    static func edition(_ id: String) -> ClawdEdition? { index[id] }
    static func editions(in collection: ClawdCollection) -> [ClawdEdition] { all.filter { $0.collection == collection } }
}
