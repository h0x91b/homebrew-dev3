class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.18.6"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.18.6/dev3-cli-macos-arm64.tar.gz"
      sha256 "aa952329884cf14a29d2e9e4d82c0e35059c678d7dbab368e50b89b4bc87cac6"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.18.6/dev3-cli-macos-x64.tar.gz"
      sha256 "3bd1bb3d6a572cab54c091c2e41a8f0e711f522780ab76322830e897ccb3ee8b"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.18.6/dev3-cli-linux-x64.tar.gz"
      sha256 "d9c139924e02d121896ce8105a07d1337525c887f41276976db1e07a0e9681e6"
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
