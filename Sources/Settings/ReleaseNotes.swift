import Foundation

/// What one release changed, in the app's own words.
struct ReleaseNote: Equatable {
    /// Matched against `CFBundleShortVersionString`, so it has to be exactly
    /// the string `MARKETING_VERSION` is set to.
    let version: String
    /// One line under the title. What this release is *about*.
    let headline: String
    let changes: [Change]

    /// A title carries the change; the detail is optional, so a small fix can
    /// be a single line rather than a line padded out to match its neighbours.
    struct Change: Equatable {
        let title: String
        let detail: String

        init(title: String, detail: String = "") {
            self.title = title
            self.detail = detail
        }
    }
}

/// The release history the app ships with.
///
/// Written here rather than fetched from the appcast: it has to be there on a
/// first launch with no network, and it belongs to the build it describes.
/// Bumping `MARKETING_VERSION` without adding an entry is caught by
/// `testTheCurrentVersionHasANote`.
enum ReleaseNotes {
    static var all: [ReleaseNote] {
        [
            ReleaseNote(
                version: "1.0.0",
                headline: L10n.t("Your Mac's notch, as a Dynamic Island for your coding assistants."),
                changes: [
                    ReleaseNote.Change(
                        title: L10n.t("Only real numbers"),
                        detail: L10n.t("Every percentage comes from the provider's own usage endpoint, the same one its CLI reads. Nothing is estimated or paced.")
                    ),
                    ReleaseNote.Change(
                        title: L10n.t("It grows out of the notch"),
                        detail: L10n.t("At rest nothing is drawn: the hardware notch is Halo. Reach for it and it expands from the cutout, and hovering a ring opens its report. No handles, no extra chrome.")
                    ),
                    ReleaseNote.Change(
                        title: L10n.t("Lives in the menu bar"),
                        detail: L10n.t("No Dock icon. Settings and Quit are one click away from the Halo icon.")
                    ),
                    ReleaseNote.Change(
                        title: L10n.t("Any size you like"),
                        detail: L10n.t("A continuous size slider, from 60% to 200%, so the open notch matches your screen.")
                    ),
                    ReleaseNote.Change(
                        title: L10n.t("Built on Codenotch"),
                        detail: L10n.t("Halo is a fork of Codenotch by Vinz, MIT licensed. Claude Code, Codex, Cursor, Copilot and the rest read exactly as they did there.")
                    ),
                ]
            ),
        ]
    }

    static func note(for version: String) -> ReleaseNote? {
        all.first { $0.version == version }
    }

    /// The note worth showing on this launch, if there is one.
    ///
    /// `notes` is a parameter so the rule can be tested against a fixed history
    /// rather than against whatever the app happens to ship this week.
    static func unseen(in version: String,
                       lastSeen: String?,
                       notes: [ReleaseNote] = ReleaseNotes.all) -> ReleaseNote? {
        guard lastSeen != version else { return nil }
        return notes.first { $0.version == version }
    }
}
