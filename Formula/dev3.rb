class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.29.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.29.3/dev3-cli-macos-arm64.tar.gz"
      sha256 "305d7a7b2755f12ba770b1fc5347cacf5f3d115432c4914802d905273fc74085"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.29.3/dev3-cli-macos-x64.tar.gz"
      sha256 "6d07b155157cd1f15be290d153a2223e4810dd2000bcbaffa5542d17fd588cae"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.29.3/dev3-cli-linux-x64.tar.gz"
      sha256 "498e1e58d81fb7312ca0daf085944160d0f9e0d36c746fe3a92869500d07d1d8"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.29.3/dev3-cli-linux-arm64.tar.gz"
        sha256 "a84af2fba8fb5ef6464f44660354a145274aa4a5798d6683545884e57c87da0f"
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
