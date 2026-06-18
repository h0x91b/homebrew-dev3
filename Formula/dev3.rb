class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.23.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.23.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "62dd330482ae207ea75a2b2e410a94e226bb2919e3a006d598a966ad3e28995a"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.23.0/dev3-cli-macos-x64.tar.gz"
      sha256 "888ec3006f67df8b771b67529e433b79e09937cd6acf6ab9a6ac5fabe3634488"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.23.0/dev3-cli-linux-x64.tar.gz"
      sha256 "2d4a4d9bdd8117ef362b0e9507de73f298934b8bf1ccbd29ba7971bb4ca6e0e7"
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
