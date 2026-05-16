class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.13.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.13.1/dev3-cli-macos-arm64.tar.gz"
      sha256 "6603f5f48a1b80273e562da6a8aee13408201297be8922bf23aa50f0781137b2"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.13.1/dev3-cli-macos-x64.tar.gz"
      sha256 "12305f1bd7f5c4ce1c8898291867add953d636231a9d747a9f69b5915ebb7dc2"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.13.1/dev3-cli-linux-x64.tar.gz"
      sha256 "4a255a95d6954cb0042a85b923c9dfe98a198a23c9b3b5bbbac28815e8729a40"
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
