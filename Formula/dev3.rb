class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.31.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.31.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "13a00c43fa0e441bf658946d37a28da7070d517675cd063a59dae0ac3da72b12"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.31.0/dev3-cli-macos-x64.tar.gz"
      sha256 "0850d11938937349ec986068e208c427bb96aeaa9a56d253aa0570ddd674552e"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.31.0/dev3-cli-linux-x64.tar.gz"
      sha256 "217b6f442a78e70bfda8070b089eb1db98197bc15ff7d25d1d4967293a431fe5"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.31.0/dev3-cli-linux-arm64.tar.gz"
        sha256 "90a0f25b91cae4732293b52fe4fb8803e87eb4ee9289f2645ef0e69ecb755c24"
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
