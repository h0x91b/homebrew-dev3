class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.19.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.19.2/dev3-cli-macos-arm64.tar.gz"
      sha256 "1ed5da8e823fab16f3cfb4e4f8c9a0e9d4f63f8a8dd699c82d57e80988afe96f"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.19.2/dev3-cli-macos-x64.tar.gz"
      sha256 "7deedca6698fdd3083c10f2f8adf3939e7f1c141bb87bc59bd041fb1cc0ce720"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.19.2/dev3-cli-linux-x64.tar.gz"
      sha256 "fc7692bb5fc0e96fbec806aae2658176c6d2be6638bbaf28c8afbbab3f9f31ed"
    end
  end

  depends_on "tmux"
  depends_on "git"
  depends_on "cloudflared"

  def install
    libexec.install "dev3", "dev3-server", "dist"
    chmod 0755, libexec/"dev3"
    chmod 0755, libexec/"dev3-server"
    # Only link `dev3`. The compiled `dev3-server` is spawned by
    # `dev3` via realpath(execPath)/dev3-server, so it finds itself
    # next to the real binary in libexec.
    bin.install_symlink libexec/"dev3"
  end

  test do
    assert_match "dev3", shell_output("#{bin}/dev3 --version")
  end
end
