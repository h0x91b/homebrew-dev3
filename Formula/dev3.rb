class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.11.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.11.3/dev3-cli-macos-arm64.tar.gz"
      sha256 "06afd7a57536178104582ed97cd7880cd64f0ae75c886d6e48e5d3f75bb7bc3a"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.11.3/dev3-cli-macos-x64.tar.gz"
      sha256 "5288e233c06a8bab74f6885fc9f8357eed77cc1124eb8ee40f4b854a9a9a9420"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.11.3/dev3-cli-linux-x64.tar.gz"
      sha256 "2b9389f5f2b927afe279b082e3bbfad60752bcd3af20bf1e7b8df24d2e03a179"
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
