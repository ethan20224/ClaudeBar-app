import Foundation
import Observation

/// What the popover needs to draw Clawd and the Clawdex. Written by `MascotController`.
@MainActor
@Observable
final class ClawdModel {
    private(set) var plan = ClawdPlan()
    private(set) var timeline: ClawdTimeline?
    private(set) var planStart = Date()
    var unlocked: Set<String> = []
    var pins: [ClawdSlot: String] = [:]
    var edition: String?
    var sceneChoice: String?
    var disabledMicros: Set<String> = []
    var favorites: Set<String> = []
    var seenEditions: Set<String> = []
    var cardFinishes: [String: ClawdCardFinish] = [:]
    var animationsPaused = false

    @ObservationIgnored var onToggleAnimations: (() -> Void)?
    @ObservationIgnored var onPet: (() -> Void)?
    @ObservationIgnored var onEyeLook: ((Int) -> Void)?
    @ObservationIgnored var onPin: ((ClawdItem) -> Void)?
    @ObservationIgnored var onUnpin: ((ClawdSlot) -> Void)?
    @ObservationIgnored var onClearPins: (() -> Void)?
    @ObservationIgnored var onWearEdition: ((String?) -> Void)?
    @ObservationIgnored var onToggleFavorite: ((String) -> Void)?
    @ObservationIgnored var onMarkSeen: (([String]) -> Void)?
    @ObservationIgnored var onSetCardFinish: ((String, ClawdCardFinish) -> Void)?
    @ObservationIgnored var onPickScene: ((String?) -> Void)?
    @ObservationIgnored var onPreviewMood: ((MascotState) -> Void)?
    @ObservationIgnored var onPlayMicro: ((MicroMoment) -> Void)?
    @ObservationIgnored var onSetMicroEnabled: ((MicroMoment, Bool) -> Void)?
    @ObservationIgnored var onOpenWindow: (() -> Void)?

    func cardFinish(for editionID: String) -> ClawdCardFinish {
        cardFinishes[editionID] ?? .matte
    }

    /// What to call Clawd right now: the worn edition, else the scene or outfit, else just Clawd.
    var displayName: String {
        if let e = plan.edition.flatMap(ClawdEditions.edition) { return e.name }
        switch plan.scene {
        case .treadmillJog?, .treadmillSprint?: return "Treadmill"
        case .wizard?: return "Wizard"
        case nil: break
        }
        if let id = plan.outfits.first, let item = ClawdCatalog.item(id) { return item.name }
        return "Clawd"
    }

    /// A quiet second line: the edition's collection, else the current mood.
    var displaySubtitle: String {
        if let e = plan.edition.flatMap(ClawdEditions.edition) { return e.collection.title }
        if plan.pet { return "Happy" }
        return ClawdCatalog.item(plan.mood.catalogID)?.name ?? ""
    }

    func show(plan: ClawdPlan, timeline: ClawdTimeline) {
        self.plan = plan
        self.timeline = timeline
        self.planStart = Date()
    }
}
