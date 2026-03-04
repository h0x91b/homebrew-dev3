cask "dev3" do
  version "0.3.8"
  sha256 "1c81aeea53988180ce157f566b51a4bdd61c1acbbbbc28087b669258d591aeb1"

  url "https://github.com/h0x91b/dev-3.0/releases/download/v#{version}/stable-macos-arm64-dev-3.0.dmg"
  name "dev-3.0"
  desc "Terminal-centric project manager for AI coding agents"
  homepage "https://h0x91b.github.io/dev-3.0/"

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"
  depends_on formula: "git"
  depends_on formula: "tmux"

  app "dev-3.0.app"

  zap trash: [
    "~/Library/Application Support/dev3.electrobun.dev",
    "~/Library/Preferences/dev3.electrobun.dev.plist",
    "~/Library/Caches/dev3.electrobun.dev",
  ]
end
