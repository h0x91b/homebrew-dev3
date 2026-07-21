cask "dev3" do
  version "1.37.4"
  sha256 "17dec5c9fca646f4fe87b09612cd3646bca15247bf6e2452c82627589fb3987c"

  url "https://github.com/h0x91b/dev-3.0/releases/download/v#{version}/stable-macos-arm64-dev-3.0.dmg"
  name "dev-3.0"
  desc "Terminal-centric project manager for AI coding agents"
  homepage "https://h0x91b.github.io/dev-3.0/"

  # The app updates itself via the in-app updater, so most installs
  # drift ahead of the Caskroom-recorded version. Without this flag a
  # bulk `brew upgrade` tries to "upgrade" such installs and can rip
  # the bundle from under a running instance (or die mid-move on the
  # stale Caskroom state). auto_updates makes bulk `brew upgrade`
  # skip dev3; an explicit `brew upgrade --cask dev3` still works.
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :ventura
  depends_on formula: "git"
  # No tmux dependency: the app bundle ships its own self-contained
  # pinned tmux (Resources/app/tmux) — see decisions/137. Existing
  # installs with the h0x91b/dev3/tmux@3.6 keg keep working (the keg
  # is the second resolution tier after the bundled binary).
  depends_on formula: "cloudflared"

  app "dev-3.0.app"

  zap trash: [
    "~/Library/Application Support/dev3.electrobun.dev",
    "~/Library/Caches/dev3.electrobun.dev",
    "~/Library/Preferences/dev3.electrobun.dev.plist",
  ]
end
