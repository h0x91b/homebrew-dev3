class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.27.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.27.1/dev3-cli-macos-arm64.tar.gz"
      sha256 "afda66d9a0beee8ecc9c7e0f26a2192568664f7846bd63344bc9405446966e3b"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.27.1/dev3-cli-macos-x64.tar.gz"
      sha256 "c5bcdbd673d9d9cc8fb0ecf9f7d34f03be6702aae2da235bf55ddd8856209642"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.27.1/dev3-cli-linux-x64.tar.gz"
      sha256 "d8098bd44d8f7a48ba37f9b9bbdca241f04223ecb42577882a5cf57a531df00c"
    end
  end

  depends_on "tmux"
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
