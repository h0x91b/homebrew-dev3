class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.12.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.12.2/dev3-cli-macos-arm64.tar.gz"
      sha256 "23c4b6ed83914a27b40e368730abaa0407dda539315bf5284704fbf57c175001"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.12.2/dev3-cli-macos-x64.tar.gz"
      sha256 "8b047b5a6680c07b60d9cedcb75b01c509fec86db9128c8c23122f4cefc215c1"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.12.2/dev3-cli-linux-x64.tar.gz"
      sha256 "b39e2cf80d122c535df23fb2652d67248a6496c8fd182a998eb570728167fbb2"
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
