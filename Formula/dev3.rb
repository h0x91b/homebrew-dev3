class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.12.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.12.4/dev3-cli-macos-arm64.tar.gz"
      sha256 "6efe8464213bddd72612e53a582edbc038d3c923f0385079706393a7d7b5fbde"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.12.4/dev3-cli-macos-x64.tar.gz"
      sha256 "7c3b80496b6a3ed832dccc152ab1dad9fa7a6f42ba3cd153ce80a2c9b3e567f8"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.12.4/dev3-cli-linux-x64.tar.gz"
      sha256 "f36d93f4a8172f846138fbcf509f29f674adae83a5e171f9293d92b9a4ce1928"
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
