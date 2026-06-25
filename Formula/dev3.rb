class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.26.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.26.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "d15f905b3c74af6a1a119a45c49148ebae76deb43352a9cb1e307d56888eff5b"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.26.0/dev3-cli-macos-x64.tar.gz"
      sha256 "f8871013e0a7e3bba08b549b3d32fe803a6748e51541747098061d4f0f77366f"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.26.0/dev3-cli-linux-x64.tar.gz"
      sha256 "5590556d6c1326771404ddef3fa15d85e9e44df7d4466453d4ed0493c1aeadeb"
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
