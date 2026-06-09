class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.18.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.18.4/dev3-cli-macos-arm64.tar.gz"
      sha256 "0304c7fc4d949e45230afad48ce1c500790c8c6b7bd5d78287da2384fc3a1c04"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.18.4/dev3-cli-macos-x64.tar.gz"
      sha256 "88179eaca1320706981849657bdb4b710e60dc6b43f1e6eec998a84a028bda52"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.18.4/dev3-cli-linux-x64.tar.gz"
      sha256 "7569b5d6fff6f77d8ac502ff725ffa45f21f7ee065a11d2f52f8d9fec44e81ca"
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
