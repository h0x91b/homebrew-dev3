class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.18.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.18.3/dev3-cli-macos-arm64.tar.gz"
      sha256 "96a8e22f1d0080b6c8dbf1609206c3a56d7f87e35be9ff91b2916e4ee5f636bf"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.18.3/dev3-cli-macos-x64.tar.gz"
      sha256 "894b837bef4ae4fcfa0292cdbc64cbf9b3e9bcab08f3505afaf6dfe7ea7a699f"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.18.3/dev3-cli-linux-x64.tar.gz"
      sha256 "a8cf19264fa387be64e78a3f017455fe44a6e80204fadaf0f4ff02055a91da65"
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
