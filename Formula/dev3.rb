class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.33.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.33.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "2c7ea218f66bce0708cef9a415ba348a3f3145575e65b871ae373a0a5cc70611"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.33.0/dev3-cli-macos-x64.tar.gz"
      sha256 "e2331bcc29e7e55117588952454b3ba8b9263e211ae6498cd584418472eb9076"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.33.0/dev3-cli-linux-x64.tar.gz"
      sha256 "5d5fe5a7704471653d5c64b6598d5ac7831f26904dab7c3151b0411f9df06823"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.33.0/dev3-cli-linux-arm64.tar.gz"
        sha256 "d102e16db5a522da894f0e6e017188d07d6dca4fffb6dce169fb8b03abb21e4c"
      end
  end

  # Pinned keg-only tmux — see the cask above for the 3.7 regression.
  depends_on "h0x91b/dev3/tmux@3.6"
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
