class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.25.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.25.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "e36277973fefe474740d4d4be1bd89d5f528a8161116b6193db0f61e669f083e"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.25.0/dev3-cli-macos-x64.tar.gz"
      sha256 "f667c0b7fdfa91f7ec4d20cc5d5fb6a3fccdb22fe207e77c6bbbeed17b37c549"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.25.0/dev3-cli-linux-x64.tar.gz"
      sha256 "70561b22e53bdfbaee6bbf0f173c4d9a309a9b659342cd21f709b5b4d7ed8245"
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
