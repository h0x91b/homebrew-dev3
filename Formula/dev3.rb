class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.16.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.16.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "afc754856c4cc5cb4e26742dfc0536e198248c204f96605cd34eac2b046f8b76"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.16.0/dev3-cli-macos-x64.tar.gz"
      sha256 "9de29a309962f2ca0e467639edcfed3fb08d5d81694928116c5565adb8259c72"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.16.0/dev3-cli-linux-x64.tar.gz"
      sha256 "3335e93221650ca5e5d10b0129b3ffde875780b94257a658f2cd4a61c80b6995"
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
