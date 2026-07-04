class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.29.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.29.1/dev3-cli-macos-arm64.tar.gz"
      sha256 "b796e977a66d526a81f270e2c8fa7c06c693ff464a2a3b1c357601bd48c0e578"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.29.1/dev3-cli-macos-x64.tar.gz"
      sha256 "7063c7633cc32ca7cac8a9e9017ffdc8aac4a778f0fba93ae3f1d7fc9cda4815"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.29.1/dev3-cli-linux-x64.tar.gz"
      sha256 "5c1eae17c55d7df2067db2c887dd9005ec0d1b99185effcd1b584ff2240c50bf"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.29.1/dev3-cli-linux-arm64.tar.gz"
        sha256 "b5a21b5d5e1db1d2ef1fcf57417f1e2ff1aa444f0500fa530f88c359f729145d"
      end
  end

  # Pinned keg-only tmux — see the cask above for the 3.7 regression.
  depends_on "h0x91b/dev3/tmux@3.6"
  depends_on "git"
  depends_on "cloudflared"

  def install
    libexec.install "dev3", "dist"
    chmod 0755, libexec/"dev3"
    # `dev3` is a single binary that is both the CLI and the headless
    # server (`dev3 remote` boots the server in-process). It serves the
    # UI from the sibling `dist/` resolved via realpath(execPath), so it
    # finds itself next to the real binary in libexec.
    bin.install_symlink libexec/"dev3"
  end

  test do
    assert_match "dev3", shell_output("#{bin}/dev3 --version")
  end
end
