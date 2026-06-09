class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.18.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.18.5/dev3-cli-macos-arm64.tar.gz"
      sha256 "73f299c26048e97d022acfb22f00dba3cb691b07cd69c1c31273d6a7478f9cd6"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.18.5/dev3-cli-macos-x64.tar.gz"
      sha256 "690a336906bd4c9302967ed281b2f50c22ea8baeeee884abf00eb76feddb8c6c"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.18.5/dev3-cli-linux-x64.tar.gz"
      sha256 "5c79a9f11d70bcb3a4e5271bde1f4598ca0805200ac2dd70a6c05bf12d309846"
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
