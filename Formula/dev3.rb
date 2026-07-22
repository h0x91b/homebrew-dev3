class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.38.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.38.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "5afae762bcea6ab8b5be9fa486965c43772983ea4bf3656782401f08f0f45713"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.38.0/dev3-cli-macos-x64.tar.gz"
      sha256 "a5acafe4f17bcc1809a750aa19be792fc853bdd18bfc41b9de6e23298ebaedb0"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.38.0/dev3-cli-linux-x64.tar.gz"
      sha256 "50dddc7de978056354525c4fa31563173069e6caa94a13068f940f2f81931938"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.38.0/dev3-cli-linux-arm64.tar.gz"
        sha256 "44c55f112c7512125740f60bac3051c7368902505eb6950b8ee8301185d0d9a9"
      end
  end

  # No tmux dependency on macOS: the tarball ships a self-contained
  # pinned tmux next to the binary (decisions/137). Linux tarballs
  # don't carry it yet, so Linux keeps the pinned keg — without it a
  # fresh Linux install on a tmux-less box would have no tmux at all.
  on_linux do
    depends_on "h0x91b/dev3/tmux@3.6"
  end
  depends_on "git"
  depends_on "cloudflared"

  def install
    libexec.install "dev3", "dist"
    chmod 0755, libexec/"dev3"
    # Bundled self-contained tmux (macOS tarballs only). The app
    # resolves it at libexec/tmux/tmux — next to the real binary,
    # same layout as the extracted tarball.
    if File.exist?("tmux")
      libexec.install "tmux"
      chmod 0755, libexec/"tmux/tmux"
    end
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
