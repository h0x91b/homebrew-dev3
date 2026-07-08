class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.32.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.32.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "95e7f8cc43e80d6a4817075dd1c43d51382125992cfd4d4372860303e1f28d30"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.32.0/dev3-cli-macos-x64.tar.gz"
      sha256 "e872bccf5259bac144ce52583d03d7faf36d5511fb31317fc9522fab93a7b66f"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.32.0/dev3-cli-linux-x64.tar.gz"
      sha256 "62eb841ee47217022b2e7a9e085a3b696461f790344c175c89a0e5b9cb35ebc1"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.32.0/dev3-cli-linux-arm64.tar.gz"
        sha256 "71e27cd1934c42742f1cdcbfd1c743d84d332c3a2e4bdfbaf3a64f49be5588bc"
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
