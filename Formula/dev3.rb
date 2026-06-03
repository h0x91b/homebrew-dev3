class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.18.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.18.1/dev3-cli-macos-arm64.tar.gz"
      sha256 "b8974af92a4b3b175eccbf84d88fef6d104d2e5a803359eec7212e18e4a052b9"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.18.1/dev3-cli-macos-x64.tar.gz"
      sha256 "5ef81ce157b8fc9ea768538f6cf6cf96336b817986f38ea2192319d4ec5fb517"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.18.1/dev3-cli-linux-x64.tar.gz"
      sha256 "7230970651dfdf6cc3603bfe18db2951c50d4c0a5abc785fd4dafdf0bb42b0e1"
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
