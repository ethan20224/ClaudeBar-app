import Foundation

/// Decides which outfit is worn in each slot right now.
/// A pinned item wins over the automatic pick; locked items are never worn.
enum ClawdWardrobe {
    struct Outcome: Equatable {
        var outfits: [String] = []
        var skin: String?
        var shinyColor: UInt32?
    }

    static func resolve(ctx: ClawdContext, progress: ClawdProgress) -> Outcome {
        let unlocked = progress.unlocked
        let pins = progress.pins
        var out = Outcome()

        for slot in [ClawdSlot.head, .face, .hand, .back, .aura] {
            if let pinned = pins[slot], ClawdCatalog.item(pinned) != nil {
                out.outfits.append(pinned)
            } else if let auto = ClawdCatalog.outfits.first(where: {
                $0.slot == slot && unlocked.contains($0.id) && $0.wear(ctx)
            }) {
                out.outfits.append(auto.id)
            }
        }

        let shinyToday = ClawdProgress.shinyColor(on: ctx.now, calendar: ctx.calendar)
        if let pinned = pins[.skin], ClawdCatalog.item(pinned) != nil {
            out.skin = pinned
        } else if shinyToday != nil, unlocked.contains("shiny") {
            out.skin = "shiny"
        } else if unlocked.contains("golden") {
            out.skin = "golden"
        }
        out.shinyColor = shinyToday ?? ClawdCatalog.shinyColors.first
        return out
    }
}
