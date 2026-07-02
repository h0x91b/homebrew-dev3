class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.27.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.27.4/dev3-cli-macos-arm64.tar.gz"
      sha256 "7e90aaae2d76254e1a98cbe84673aeb28f121564f304eee1a46c9dc0f1ffe61d"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.27.4/dev3-cli-macos-x64.tar.gz"
      sha256 "d5227594f63c76b4f8107a54b173409b2af5391c8cb9358babe2ec5c5aa2df3c"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.27.4/dev3-cli-linux-x64.tar.gz"
      sha256 "23b5e3659c8e1272c31d65062f4ba1e5741e9b2792c58eb1d0a4f4fde6e25c32"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.27.4/dev3-cli-linux-arm64.tar.gz"
        sha256 "e37b4de6ae6bab3d5ff3f68de8f9271f986310711417f9462506c30164d2d928"
      end
  end

  depends_on "tmux"
  depends_on "git"
  depends_on "cloudflared"

  def install
    libexec.install "dev3", "dist"
    chmod 0755, libexec/"dev3"
    # `dev3` is a single binary that is both the CLI and the headless
    # server (`dev3 remote` boots the server in-process). It serves the
    # UI from the sibling `dist/` resolved via realpath(execPath), so it
    # finds itself next to the real binary in libexec.
    bin.install_symlink libexec/"dev3"
  end

  test do
    assert_match "dev3", shell_output("#{bin}/dev3 --version")
  end
end
