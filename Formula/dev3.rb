class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.26.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.26.1/dev3-cli-macos-arm64.tar.gz"
      sha256 "403b0aa8fca58934967263c9b1babaf4728dc87db1d6b2fb3d39d11578a13c1b"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.26.1/dev3-cli-macos-x64.tar.gz"
      sha256 "6d20e13ea6b7b14665f0ba1c026ef0b7929354d2cdec8b50b25b825e47436ba6"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.26.1/dev3-cli-linux-x64.tar.gz"
      sha256 "b1ee5240e43a7642500cc884f9f95915606b413f70b2a41e0a099bb83b8340dd"
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
