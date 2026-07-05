class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.29.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.29.2/dev3-cli-macos-arm64.tar.gz"
      sha256 "6384db11ee36334978bcfeff4193379390baf61323658640f72fbb6b1474b3f9"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.29.2/dev3-cli-macos-x64.tar.gz"
      sha256 "69719df6ec570d1dfaddc8927bd0297be9f110278efc7eae90f79d1bcd05c52d"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.29.2/dev3-cli-linux-x64.tar.gz"
      sha256 "38b939ad4d55a74530f2eab14a28ee29a8394fb96e25951eb76ef8591f9de669"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.29.2/dev3-cli-linux-arm64.tar.gz"
        sha256 "17c93d001b65a199122629fd64875e4c4fad4f216008a01a3fca8de922b2d81f"
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
