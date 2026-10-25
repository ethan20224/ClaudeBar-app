import SwiftUI
import CoreText

/// Silkscreen pixel font, bundled in `Resources/Fonts` (SIL OFL, see OFL.txt).
///
/// `Bundle.module` is SwiftPM's generated accessor. It looks for `ClaudeBar_ClaudeBar.bundle`
/// next to the executable (`swift run`, `.build/<config>/`) and in `Bundle.main.resourceURL`
/// (a packaged .app: copy the bundle into `Contents/Resources`). If neither exists it traps,
/// so lookups here are done only inside `register()`, once.
enum CartridgeFont {
    private static let regularName = "Silkscreen-Regular"
    private static let boldName = "Silkscreen-Bold"

    /// Registers both TTFs for this process. Safe to call repeatedly.
    static func register() { _ = registered }

    private static let registered: Bool = {
        var ok = false
        for file in [regularName, boldName] {
            guard let url = fontURL(file) else { continue }
            var error: Unmanaged<CFError>?
            if CTFontManagerRegisterFontsForURL(url as CFURL, .process, &error) {
                ok = true
            } else if let err = error?.takeRetainedValue(),
                      CFErrorGetCode(err) == CTFontManagerError.alreadyRegistered.rawValue {
                ok = true
            }
        }
        return ok
    }()

    /// `.process` flattens resources into the bundle root on some toolchains and keeps the
    /// folder on others, so try both.
    private static func fontURL(_ name: String) -> URL? {
        let b = Bundle.module
        return b.url(forResource: name, withExtension: "ttf", subdirectory: "Fonts")
            ?? b.url(forResource: name, withExtension: "ttf")
            ?? b.url(forResource: name, withExtension: "ttf", subdirectory: "Resources/Fonts")
    }

    static func font(_ size: CGFloat, bold: Bool = false) -> Font {
        register()
        let name = bold ? boldName : regularName
        if CTFontCopyPostScriptName(CTFontCreateWithName(name as CFString, size, nil)) as String == name {
            return .custom(name, size: size)
        }
        return .system(size: size, weight: bold ? .bold : .regular, design: .monospaced)
    }
}
