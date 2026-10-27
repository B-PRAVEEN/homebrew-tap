cask "copyhistory" do
  version "0.1.0"
  sha256 "7671e1524a638c56658b3258f1fd62f5c0533c95122c533bc3ed849c787031dd"

  url "https://github.com/B-PRAVEEN/CopyHistory/releases/download/v#{version}/CopyHistory-#{version}.zip"
  name "CopyHistory"
  desc "Menu-bar clipboard history with secret detection"
  homepage "https://github.com/B-PRAVEEN/CopyHistory"

  depends_on macos: :sonoma

  app "CopyHistory.app"

  uninstall quit: "io.github.b-praveen.copyhistory"

  # Paths from the code: HistoryStore (Application Support/CopyHistory: history.json, images/,
  # side files, backups) and UserDefaults.standard (the preferences plist).
  zap trash: [
    "~/Library/Application Support/CopyHistory",
    "~/Library/Preferences/io.github.b-praveen.copyhistory.plist",
  ]

  caveats <<~EOS
    CopyHistory is ad-hoc signed and NOT notarised by Apple (no Developer ID),
    so macOS blocks the first launch. To approve it once:
      macOS 15 Sequoia and later: open the app, dismiss the warning, then go to
        System Settings > Privacy & Security and click "Open Anyway".
      macOS 14 Sonoma: Control-click (right-click) CopyHistory in /Applications,
        choose Open, then Open again.

    Permissions:
      Accessibility (required for auto-paste): System Settings > Privacy & Security >
        Accessibility > enable CopyHistory. Without it, pasting falls back to copy-only.
      Input Monitoring (only for Paste Stack): System Settings > Privacy & Security >
        Input Monitoring > enable CopyHistory, then relaunch the app.
    Because the signature is ad-hoc, every upgrade is a new signature: macOS may still
    show the Accessibility toggle as on while ignoring it. Re-grant it (and Input Monitoring) after upgrading,
    or reset with:
      tccutil reset Accessibility io.github.b-praveen.copyhistory
      tccutil reset ListenEvent io.github.b-praveen.copyhistory

    Before uninstalling, turn off Launch at Login in CopyHistory's Settings.
    `brew uninstall --zap` does not remove pinned secrets from your login Keychain;
    delete items for the service "io.github.b-praveen.copyhistory.pinned-secrets"
    in Keychain Access if you want them gone.
  EOS
end
