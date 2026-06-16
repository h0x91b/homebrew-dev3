class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.21.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.21.1/dev3-cli-macos-arm64.tar.gz"
      sha256 "4d0be76f6eabd73133ff8400bc0bb2d070e9f0d8496cf6a8d19b29519f22b69c"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.21.1/dev3-cli-macos-x64.tar.gz"
      sha256 "4d25b041ba2dd6317c3ba65baad91d8ef1e6e459fa7eb5982143961a948aa120"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.21.1/dev3-cli-linux-x64.tar.gz"
      sha256 "a49f3a686e882ea387f83fa9f898622215abd4c05505d5579eed040454b296e1"
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
