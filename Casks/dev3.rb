cask "dev3" do
  version "1.32.0"
  sha256 "c1a15bed410ae9ae93347482b096aded862a2660829a887fb9b61edb525493ca"

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
  # Pinned keg-only tmux from this tap: tmux 3.7 regressed (client
  # busy-spins on a congested server socket). The app prefers the
  # /opt/homebrew/opt/tmux@3.6 keg and shims it into agent PATHs,
  # so it does not need to be linked.
  depends_on formula: "h0x91b/dev3/tmux@3.6"
  depends_on formula: "cloudflared"

  app "dev-3.0.app"

  zap trash: [
    "~/Library/Application Support/dev3.electrobun.dev",
    "~/Library/Caches/dev3.electrobun.dev",
    "~/Library/Preferences/dev3.electrobun.dev.plist",
  ]
end
