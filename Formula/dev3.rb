class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.14.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.14.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "d01e06eadaa0d5b4331edee55eb5e1c3c39c8a6c9a7e6e872fffeed713ad841c"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.14.0/dev3-cli-macos-x64.tar.gz"
      sha256 "21c8a98e4e8e057e513419214d83a367d1291f62339d98ad93f876916951c122"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.14.0/dev3-cli-linux-x64.tar.gz"
      sha256 "231da77653dde402663c828d1923b96cf9c8e12b50b46d3144b2c405e02e44b2"
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
