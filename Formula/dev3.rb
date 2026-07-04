class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.29.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.29.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "bf5138f761efbe7102d0d3f77ff5b41061f22e6f8a656b4c4191d0305948961b"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.29.0/dev3-cli-macos-x64.tar.gz"
      sha256 "c03685305565f1e2e00ff9027ac64c963f60048c1f6c822b21af01bbcbec87b4"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.29.0/dev3-cli-linux-x64.tar.gz"
      sha256 "998641b71de5faed11614e92a4b4b3dbaec401f0a296f6a31f40afde41330003"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.29.0/dev3-cli-linux-arm64.tar.gz"
        sha256 "ea4302bcc9b6bc8ec3ebe14749a1d1e7e677b9552989eceb125d45a47134d332"
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
