class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.15.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.15.1/dev3-cli-macos-arm64.tar.gz"
      sha256 "ad2aae853b69d4c7b787cf0cc11f136996ca41a6a48023f9b46d8fa14ac857f4"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.15.1/dev3-cli-macos-x64.tar.gz"
      sha256 "a7cfab4358e434072b5020dd69c24f2c541f053abc84b31c4916968e9aec0cf6"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.15.1/dev3-cli-linux-x64.tar.gz"
      sha256 "783aaf897ad3900277436389343ff9c1d7e5195ff90ac132e82f82724a6649b0"
    end
  end

  depends_on "tmux"
  depends_on "git"

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
