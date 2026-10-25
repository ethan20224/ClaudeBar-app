import AppKit

/// Turns usage + local signals into Clawd's current plan, and drives the menu bar image.
@MainActor
final class MascotController {
    var onImage: ((NSImage) -> Void)?
    let model = ClawdModel()

    private let resolver: MascotStateResolver
    private let detector: ClaudeProcessDetector
    private let streak: StreakTracker
    private let progress: ClawdProgress
    private let animator = MascotAnimator()
    private let micro = MascotMicroScheduler()

    private var lastUsage: UsageData?
    private var currentPlan: ClawdPlan?
    private var oneShotActive = false
    private var pet = false
    private var eyeLook = 0
    private var darkBackdrop = false
    private let defaults: UserDefaults
    private var systemReduceMotion = false
    /// The Clawd pause choice. nil follows macOS Reduce Motion; once set, it wins over it.
    private var animationOverride: Bool?
    private var reduceMotion: Bool { animationOverride.map { !$0 } ?? systemReduceMotion }
    private static let animationKey = "mascot.animationOverride"
    private var petTask: Task<Void, Never>?
    private var previewState: MascotState?
    private var previewTask: Task<Void, Never>?

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.animationOverride = defaults.object(forKey: Self.animationKey) as? Bool
        self.resolver = MascotStateResolver(now: Date())
        self.detector = ClaudeProcessDetector()
        self.streak = StreakTracker(defaults: defaults)
        self.progress = ClawdProgress(defaults: defaults)

        animator.onImage = { [weak self] image in self?.onImage?(image) }
        animator.onOneShotFinished = { [weak self] in
            guard let self else { return }
            self.oneShotActive = false
            self.pet = false
            self.currentPlan = nil
            self.refresh()
        }
        detector.onChange = { [weak self] _ in self?.refresh() }
        micro.onTrigger = { [weak self] moment in self?.playMicro(moment) }
        micro.pick = { [weak self] in self?.enabledMicros.randomElement() ?? .stretch }

        model.onPickScene = { [weak self] id in
            self?.progress.sceneChoice = id
            self?.refresh(force: true)
        }
        model.onPreviewMood = { [weak self] state in self?.previewMood(state) }
        model.onPlayMicro = { [weak self] moment in self?.playMicroNow(moment) }
        model.onSetMicroEnabled = { [weak self] moment, on in
            guard let self else { return }
            self.progress.setMicro("\(moment)", enabled: on)
            self.publishLibrary()
            self.refresh(force: true)
        }

        model.onToggleAnimations = { [weak self] in self?.toggleAnimations() }
        model.onPet = { [weak self] in self?.petClawd() }
        model.onEyeLook = { [weak self] value in self?.setEyeLook(value) }
        model.onPin = { [weak self] item in self?.progress.pin(item); self?.refresh(force: true) }
        model.onUnpin = { [weak self] slot in self?.progress.unpin(slot: slot); self?.refresh(force: true) }
        model.onClearPins = { [weak self] in self?.progress.clearPins(); self?.refresh(force: true) }
        model.onWearEdition = { [weak self] id in
            self?.progress.edition = id
            self?.refresh(force: true)
        }
        model.onToggleFavorite = { [weak self] id in
            guard let self else { return }
            self.progress.toggleFavorite(id)
            self.publishLibrary()
        }
        model.onMarkSeen = { [weak self] ids in
            guard let self else { return }
            self.progress.markSeen(ids)
            self.publishLibrary()
        }
        model.onSetCardFinish = { [weak self] editionID, finish in
            guard let self else { return }
            self.progress.setCardFinish(finish, for: editionID)
            self.publishLibrary()
        }
        publishLibrary()
    }

    func start() { detector.start() }

    func stop() {
        detector.stop()
        animator.stop()
        micro.stop()
        petTask?.cancel()
    }

    func setReduceMotion(_ value: Bool) {
        systemReduceMotion = value
        if value { micro.stop() }
        refresh(force: true)
    }

    /// False while Clawd is holding still, whether paused by the header toggle or by Reduce Motion.
    var motionAllowed: Bool { !reduceMotion }

    func toggleAnimations() {
        setAnimationOverride(!motionAllowed)
    }

    private func setAnimationOverride(_ value: Bool) {
        animationOverride = value
        defaults.set(value, forKey: Self.animationKey)
        publishLibrary()
        // A one-shot (sneeze, dance, scene) finishes first; its end-of-play refresh applies the new state.
        if !oneShotActive { refresh(force: true) }
    }

    func setDarkBackdrop(_ value: Bool) {
        guard value != darkBackdrop else { return }
        darkBackdrop = value
        refresh(force: true)
    }

    func setEyeLook(_ value: Int) {
        let clamped = max(-1, min(1, value))
        guard clamped != eyeLook else { return }
        eyeLook = clamped
        refresh(force: true)
    }

    func update(usage: UsageData?) {
        lastUsage = usage
        refresh()
    }

    func petClawd() {
        guard !pet else { return }
        HapticService.playPet()
        pet = true
        progress.unlock("mood-pet")
        oneShotActive = false
        refresh(force: true)
        if reduceMotion {
            petTask?.cancel()
            petTask = Task { [weak self] in
                try? await Task.sleep(for: .seconds(1.6))
                guard !Task.isCancelled else { return }
                self?.pet = false
                self?.refresh(force: true)
            }
        }
    }

    private func refresh(force: Bool = false) {
        if oneShotActive && !force { return } // let a celebration or fidget finish

        let now = Date()
        let resolution = resolver.resolve(usage: lastUsage, isClaudeProcessLive: detector.isLive, now: now)
        let util = lastUsage?.fiveHour.utilization ?? 0

        streak.recordActivity(active: resolution.state == .working, on: now)
        progress.recordPoll(utilization: util, now: now)

        let ctx = ClawdContext(
            now: now, utilization: util, burnPerHour: resolution.burnPerHour,
            streak: streak.currentStreak, calmDays: progress.calmDays(now: now),
            installDate: progress.installDate, claudeLive: detector.isLive,
            liveMinutes: resolution.liveMinutes, regionCode: Locale.current.region?.identifier)
        let fresh = progress.evaluate(ctx)

        var mood = resolution.state
        if resolution.didCrossReset { mood = .reset }
        // A Clawdex preview shows another mood for a few seconds; real usage resumes after.
        if let previewState { mood = previewState }
        progress.unlock(mood.catalogID)

        let edition = progress.edition
        var scene = Self.scene(for: mood, ctx: ctx)
        if let picked = progress.sceneChoice, [.idle, .working, .sleepy].contains(mood) {
            scene = picked == "wizard" ? .wizard : .treadmillJog
        }
        // A worn edition owns the whole look, so no treadmill/wizard scene underneath it.
        if edition != nil { scene = nil }
        if scene == .treadmillJog || scene == .treadmillSprint { progress.unlock("treadmill") }
        if scene == .wizard { progress.unlock("wizard") }

        let wardrobe = ClawdWardrobe.resolve(ctx: ctx, progress: progress)

        var plan = ClawdPlan(mood: mood, scene: scene, pet: pet,
                             outfits: edition == nil ? wardrobe.outfits : [],
                             skin: edition == nil ? wardrobe.skin : nil,
                             shinyColor: wardrobe.shinyColor, edition: edition, eyeLook: eyeLook,
                             darkBackdrop: darkBackdrop, reduceMotion: reduceMotion)
        // Celebrate a brand-new unlock with a little dance, if Clawd is just hanging out.
        if !fresh.isEmpty, mood == .idle, scene == nil, !pet, !reduceMotion { plan.micro = .dance }

        publish(ctx: ctx)
        apply(plan)

        if plan.mood == .idle && plan.scene == nil && plan.micro == nil && !pet && !reduceMotion && !enabledMicros.isEmpty {
            micro.start()
        } else {
            micro.stop()
        }
    }

    private static func scene(for mood: MascotState, ctx: ClawdContext) -> ClawdScene? {
        guard mood == .working else { return nil }
        if ctx.burnPerHour >= 30 { return .treadmillSprint }
        if ctx.burnPerHour >= 15 { return .treadmillJog }
        if ctx.liveMinutes >= 45 { return .wizard }
        return nil
    }

    private var enabledMicros: [MicroMoment] {
        let off = progress.disabledMicros
        return MicroMoment.allCases.filter { !off.contains("\($0)") }
    }

    private func previewMood(_ state: MascotState) {
        previewState = state
        previewTask?.cancel()
        oneShotActive = false
        refresh(force: true)
        previewTask = Task { [weak self] in
            try? await Task.sleep(for: .seconds(10))
            guard !Task.isCancelled else { return }
            self?.previewState = nil
            self?.oneShotActive = false
            self?.refresh(force: true)
        }
    }

    /// Plays a fidget right now, from the Clawdex.
    private func playMicroNow(_ moment: MicroMoment) {
        guard !reduceMotion, let base = currentPlan, base.scene == nil, !pet else { return }
        var plan = base
        plan.micro = moment
        oneShotActive = false
        apply(plan)
        micro.stop()
    }

    private func playMicro(_ moment: MicroMoment) {
        guard enabledMicros.contains(moment) else { return }
        guard let base = currentPlan, base.mood == .idle, base.scene == nil, base.micro == nil,
              !pet, !reduceMotion, !oneShotActive else { return }
        var plan = base
        plan.micro = moment
        apply(plan)
        micro.stop()
    }

    private func apply(_ plan: ClawdPlan) {
        guard plan != currentPlan else { return }
        currentPlan = plan
        let timeline = ClawdComposer.timeline(for: plan)
        oneShotActive = timeline.isOneShot
        model.show(plan: plan, timeline: timeline)
        animator.play(timeline)
    }

    private func publish(ctx: ClawdContext) {
        model.unlocked = progress.unlocked
        model.pins = progress.pins
        publishLibrary()
    }

    private func publishLibrary() {
        model.edition = progress.edition
        model.sceneChoice = progress.sceneChoice
        model.disabledMicros = progress.disabledMicros
        model.favorites = progress.favorites
        model.seenEditions = progress.seenEditions
        model.cardFinishes = progress.cardFinishes
        model.animationsPaused = !motionAllowed
    }
}
