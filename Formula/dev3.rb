class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.27.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.27.2/dev3-cli-macos-arm64.tar.gz"
      sha256 "5aa4010317eddd8792dfe0e6a438906b1216a9c74c86e535e47dd9a2f74e7b3a"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.27.2/dev3-cli-macos-x64.tar.gz"
      sha256 "657fa336b5315225d6885e6e78903f143147b83dc1d3b9af3f26caa18ed0445e"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.27.2/dev3-cli-linux-x64.tar.gz"
      sha256 "bc91f7b4cf7d0832caf70e61d5c9f0751931456e938dd80c17ffdb4480e66a15"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.27.2/dev3-cli-linux-arm64.tar.gz"
        sha256 "f2e9e3613149fecec27f655fa8480e30abc266246b9f44403c454d9f08fcd375"
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
