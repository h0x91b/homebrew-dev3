class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.27.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.27.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "370a3ad5cecaf735ba09aa3262c8becff700621b84ef502887c04e53603b83dd"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.27.0/dev3-cli-macos-x64.tar.gz"
      sha256 "34b0597a3d4d63f62fdad26cf4d5e8640a5575659f82206e24e0ce54890d5c02"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.27.0/dev3-cli-linux-x64.tar.gz"
      sha256 "e5da708100f0eb90ee15022f77e6e07277e5e59d5d49db02412f369418c4b108"
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
