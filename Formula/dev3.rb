class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.19.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.19.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "e966d6a393ce34ccda52bb503354cb4d7921705ef1cc7f5784ed5dc458bc3437"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.19.0/dev3-cli-macos-x64.tar.gz"
      sha256 "fdd7003ddedb1cddbe1fed988f6dc2bbb1f3ae3d72b9709ddaee0c349ed3fd1d"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.19.0/dev3-cli-linux-x64.tar.gz"
      sha256 "833ebc36024a860be1efb004614177aed223db1c1d73a1b6b53310350b2342d7"
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
