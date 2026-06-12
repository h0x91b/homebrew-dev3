class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.19.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.19.1/dev3-cli-macos-arm64.tar.gz"
      sha256 "e45c531e7f1ebce16debfc46f27f5635baa0d2b6d086ead4ae3b4d395e6a4968"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.19.1/dev3-cli-macos-x64.tar.gz"
      sha256 "3dfb035ae2b0ccecd4a5f797e0f2af587a839001b0f22fcd0a84c0f1a8e7ec4b"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.19.1/dev3-cli-linux-x64.tar.gz"
      sha256 "f0c894ff6c34854ce6ad776937afd1f76efcafb23522bb06a06e416cff262e9e"
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
