class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.35.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.35.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "8ba836047749e67e6f5474dada4b2a4e580889a6cd0851c78d73db723de1d59d"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.35.0/dev3-cli-macos-x64.tar.gz"
      sha256 "1f1cbff375261a419d2bbf5de8cc0e8f6b2cc5b70b71eeedc10b891ea0a34d96"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.35.0/dev3-cli-linux-x64.tar.gz"
      sha256 "4a880354ceff0dc8d270f23493192c0fcff71065baea6f8bf696b94398052cba"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.35.0/dev3-cli-linux-arm64.tar.gz"
        sha256 "29b47427ff026c84c6e77dba376b04cd676c3a5e3fd0b21868d401e92a0df791"
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
