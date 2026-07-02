class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.28.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.28.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "df67bf1c2a5987da5f909e37c1eeea38e53fe90a2036c42029f4b15f024ee014"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.28.0/dev3-cli-macos-x64.tar.gz"
      sha256 "13a90d33c121080c9064bd8989f155f7527926caae117e5e35a86e34f3684518"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.28.0/dev3-cli-linux-x64.tar.gz"
      sha256 "0d5b9f6878f85b97eecd5c45aa97468102731f0e486346ece941e128bbda2e5e"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.28.0/dev3-cli-linux-arm64.tar.gz"
        sha256 "153e17c17b9d43233e77fc1d84d7881739328c142fa1b285eb9a16258ff3503c"
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
