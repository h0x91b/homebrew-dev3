class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.24.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.24.1/dev3-cli-macos-arm64.tar.gz"
      sha256 "53349466d4a4bc97084150460cdede0bc3e2a852fb1bf32d29c461256f323bd9"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.24.1/dev3-cli-macos-x64.tar.gz"
      sha256 "9957702cd3404aaad8fe8a109c7141ff134d591eb0bea4c09c7a219ef2fc6aca"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.24.1/dev3-cli-linux-x64.tar.gz"
      sha256 "b67d185f15be71a18e3dfe51512e4c8a4e72369f2ee3e6786e288abca5f27773"
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
