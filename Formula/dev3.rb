class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.30.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.30.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "08eaa3ef964caa309ba3810bc5d38be8a786219f11449b7d01acafdc059e1e45"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.30.0/dev3-cli-macos-x64.tar.gz"
      sha256 "d0cbca8fc70ff83e706c80d5d4922d377c1db3f228d8520ccab0b84deecc161e"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.30.0/dev3-cli-linux-x64.tar.gz"
      sha256 "dcdcbad17e7d5a5d3ce65ee32e62b4cf5ad8c9746f35169d88681ef2171c9727"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.30.0/dev3-cli-linux-arm64.tar.gz"
        sha256 "6a41e6e7b62aa5fefdbf62e47fc87d88b3310e765463bb5b7cf5db13823fe978"
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
