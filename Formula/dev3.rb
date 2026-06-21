class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.24.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.24.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "11796af65135a30bbed4b842579a5365a37a0905ab3e248b8b5dec40c1eef5b7"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.24.0/dev3-cli-macos-x64.tar.gz"
      sha256 "065fd8da0ac906f8227a6a957373dac3bfb4f7ab7b4820a51e77a5def7de5fc0"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.24.0/dev3-cli-linux-x64.tar.gz"
      sha256 "af075ddeaea596d79f1a2f2389c765e7dbbee3b9db2f50ed2c67d37e94459359"
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
