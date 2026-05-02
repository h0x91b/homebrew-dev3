class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.11.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.11.2/dev3-cli-macos-arm64.tar.gz"
      sha256 "376ac2be8722948d139cf418d885e318a0aee00a91cec130459f683e0bb00cf9"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.11.2/dev3-cli-macos-x64.tar.gz"
      sha256 "bdca308c11a3d5a0fd0931c2df12cb280321ffe7022d786fd53626e5602e02a1"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.11.2/dev3-cli-linux-x64.tar.gz"
      sha256 "0b7c481b50d4e72d5c501280f360157cea7bb96526dde296865ef13228daf76c"
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
