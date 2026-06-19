class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.23.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.23.1/dev3-cli-macos-arm64.tar.gz"
      sha256 "7b3f5d5c6b8ab6f8005e1cfe0ed1b29ffb4b0059f7fe9bb2f0a59ae7d652d38f"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.23.1/dev3-cli-macos-x64.tar.gz"
      sha256 "fb523275e62f16f8ac67654f669227d106a9a797e486554b8b7b23afaacb6b7a"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.23.1/dev3-cli-linux-x64.tar.gz"
      sha256 "6f7eabc6e494abeb694237c84df2319e02aec1cf06c3f1959341ec3ae5294ba0"
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
