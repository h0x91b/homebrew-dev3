class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.17.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.17.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "4148c91cc03e95297d78f848df6feafbd7ee6a4bcf604b2874a956949da49ab2"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.17.0/dev3-cli-macos-x64.tar.gz"
      sha256 "4a6cac021314cda296ee68feac8072b644118294c31278898e77db22cca1af14"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.17.0/dev3-cli-linux-x64.tar.gz"
      sha256 "1d6f6f0705eb106f4a19213c13d3540bc25c75f59a0e43eddec5a026d4183fc9"
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
