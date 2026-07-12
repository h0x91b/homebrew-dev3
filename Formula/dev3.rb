class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.34.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.34.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "b4b475885a362dc63ee8f27a2987c65543e323800867c2e21c93390612c8eeeb"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.34.0/dev3-cli-macos-x64.tar.gz"
      sha256 "06c7e6433dc4738c8f9b7e520daff39b3ff52a709140aee034b5501fb4b3dcd5"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.34.0/dev3-cli-linux-x64.tar.gz"
      sha256 "5018319ff3f0add5b85c639062131902de976454349a4d3873f013ee71c83d2c"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.34.0/dev3-cli-linux-arm64.tar.gz"
        sha256 "4854e3309bd5905999a48a9938ed064d0dc40ba79d65270e7f5d6e32e2857358"
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
