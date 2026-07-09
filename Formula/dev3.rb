class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.32.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.32.1/dev3-cli-macos-arm64.tar.gz"
      sha256 "742012937b78de62277d88f17a2d00acf0b83289708e451be65b31cb33a37c71"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.32.1/dev3-cli-macos-x64.tar.gz"
      sha256 "273bbb05ba8629a675710d37636d8fbd080ca23a0a14cc4ed17c30bc6527d070"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.32.1/dev3-cli-linux-x64.tar.gz"
      sha256 "36b11146283e26eba090897a0c3162cfdcf4ecedba9744e61d8d1a2e2ebfe038"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.32.1/dev3-cli-linux-arm64.tar.gz"
        sha256 "c76baad1552ed9f4c7631ce1b9989c51197ca71ddc0926e5955a98f5016b9e0b"
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
