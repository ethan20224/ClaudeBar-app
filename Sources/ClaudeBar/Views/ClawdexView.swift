import SwiftUI

/// Renders the first frame of an item on a neutral Clawd, cached per item.
@MainActor
enum ClawdPreview {
    private static var cache: [String: NSImage] = [:]

    static func plan(for item: ClawdItem) -> ClawdPlan {
        var plan = ClawdPlan()
        switch item.kind {
        case .mood:
            switch item.id {
            case "mood-working":  plan.mood = .working
            case "mood-sleepy":   plan.mood = .sleepy
            case "mood-strained": plan.mood = .strained
            case "mood-maxed":    plan.mood = .maxed
            case "mood-locked":   plan.mood = .locked
            case "mood-reset":    plan.mood = .reset
            case "mood-pet":      plan.pet = true
            default:              plan.mood = .idle
            }
        case .outfit: plan.outfits = [item.id]
        case .skin:
            plan.skin = item.id
            plan.shinyColor = ClawdCatalog.shinyColors[0]
        case .scene:
            plan.mood = .working
            plan.scene = item.id == "wizard" ? .wizard : .treadmillSprint
        }
        return plan
    }

    static func image(for item: ClawdItem, locked: Bool, dark: Bool) -> NSImage {
        let key = "\(item.id)|\(locked)|\(dark)"
        if let hit = cache[key] { return hit }
        var (canvas, theme) = ClawdComposer.preview(for: plan(for: item))
        theme.darkBackdrop = dark
        theme.silhouette = locked
        _ = canvas
        let image = MascotRenderer.render(canvas, theme: theme, pxPerCell: 6, ptPerCell: 3)
        cache[key] = image
        return image
    }
}
