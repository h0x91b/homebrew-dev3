class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.35.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.35.2/dev3-cli-macos-arm64.tar.gz"
      sha256 "87d62136c9ead72dd4f1b01bbf7c97c7c76e92cf77e65f8a549949252d856f6e"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.35.2/dev3-cli-macos-x64.tar.gz"
      sha256 "9410a2f61b354365dc8dd711b98b85ae8b57071d7561b59f611d2431b3ffdd1b"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.35.2/dev3-cli-linux-x64.tar.gz"
      sha256 "a2c1485125249d5270c67b4db3fe55468e2c19141fc0c2a9a0d7855ab7637a35"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.35.2/dev3-cli-linux-arm64.tar.gz"
        sha256 "f4536c897b907e43b87ff12cb0967d416344a97f9af6d471e39acae17cf7b550"
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
