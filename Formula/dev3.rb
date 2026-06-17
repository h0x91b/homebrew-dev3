class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.22.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.22.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "646fb0d316b0b0f332b4a0e73558dc5873d205baafe1ab023c2b0590755e052e"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.22.0/dev3-cli-macos-x64.tar.gz"
      sha256 "fe8e2e6b4206dc9a7dfe91f2a71c4c64b251808e5d2ccc1afa5c6a2b98cf5e35"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.22.0/dev3-cli-linux-x64.tar.gz"
      sha256 "98a7e2a80d4df0fb88d8d7bef4763ba2cb72cb02098d7e214627067c0a9b831e"
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
