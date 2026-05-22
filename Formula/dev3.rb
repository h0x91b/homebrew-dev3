class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.15.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.15.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "f4a77feedf546f0ae88631c0478af81c1543a8af224a028b2f9bc07d3cb4a9bc"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.15.0/dev3-cli-macos-x64.tar.gz"
      sha256 "fe83d87edce1297fbc2769b8569b88467ae4590405be5f17a524ff7b1554b659"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.15.0/dev3-cli-linux-x64.tar.gz"
      sha256 "184cf89d8cb4d2dbb47035472ba17c97cb2af2e251625d9c192886e97cbfd8b8"
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
