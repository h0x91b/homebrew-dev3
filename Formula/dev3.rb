class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.21.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.21.2/dev3-cli-macos-arm64.tar.gz"
      sha256 "a4465bf7fb6c562880b348442e12e832963a178f3f7ddca3ff86d1b3a67ef972"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.21.2/dev3-cli-macos-x64.tar.gz"
      sha256 "a5ad3116e9e88a7e153b99147ac5a0b75847171061e3bdd665cefbee690e53f6"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.21.2/dev3-cli-linux-x64.tar.gz"
      sha256 "46be04936869e2062b00ea1bcb4cc9dbcb7dee0a3bd2865b3ffd181c00080045"
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
