class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.27.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.27.3/dev3-cli-macos-arm64.tar.gz"
      sha256 "cb4497bbd7109cdfa128f9c938bba93d395ab6e33b582d26097810ee74b5ecb7"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.27.3/dev3-cli-macos-x64.tar.gz"
      sha256 "e33a5602d986aa59809bacb4ee5d9cce4e02636f78ab4e5aeef6cccf4a663671"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.27.3/dev3-cli-linux-x64.tar.gz"
      sha256 "5ee6fcb7119ea285fb1fabea1fc2000dbdb1fc88c34808c9d382299578caa44a"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.27.3/dev3-cli-linux-arm64.tar.gz"
        sha256 "1d42fb0cda046de92cb4f8630132a4ee8d7097eeb466064fb8a0cb9758447884"
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
