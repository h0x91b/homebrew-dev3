class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.35.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.35.1/dev3-cli-macos-arm64.tar.gz"
      sha256 "609d5a2ef0aa1d7f6c156efb16a92600225050f45734c5bb62b590f8b844d2be"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.35.1/dev3-cli-macos-x64.tar.gz"
      sha256 "6661621573595492cb21329b860eafedad2689fc2d1981ce5130f1fcb25cdab9"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.35.1/dev3-cli-linux-x64.tar.gz"
      sha256 "582c5c8e38c9c7e5c6d664110ca99830adc38a462a26a7c8430faef3f252c54f"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.35.1/dev3-cli-linux-arm64.tar.gz"
        sha256 "69f7e42760d0e2bb44bc18a091a1a62ca849e6ca3758769f2e0c86903330db55"
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
