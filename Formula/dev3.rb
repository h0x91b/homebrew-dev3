class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.60.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://releases.h0x91b.com/dev-3.0/v1.60.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "96172f5f42712b193a3fab10b4bac12eda8b40ba75e60400e3632d3db6b6d125"
    end
    on_intel do
      url "https://releases.h0x91b.com/dev-3.0/v1.60.0/dev3-cli-macos-x64.tar.gz"
      sha256 "02ef4642a19a58d97426742a2ad266e4ca4c09dc078ceecceef90c2220696399"
    end
  end

  on_linux do
    on_intel do
      url "https://releases.h0x91b.com/dev-3.0/v1.60.0/dev3-cli-linux-x64.tar.gz"
      sha256 "1cb4864fc0b3e575682535cb8816a902389f179b674d61f3d9fde47168418c8b"
    end
    on_arm do
        url "https://releases.h0x91b.com/dev-3.0/v1.60.0/dev3-cli-linux-arm64.tar.gz"
        sha256 "2ca5bcc5d14acb133d905117daa5bd7493ee76553be86168ca5f53a0cf5e1c70"
      end
  end

  # No tmux dependency on macOS: the tarball ships a self-contained
  # pinned tmux next to the binary (decisions/2026/07/16/bundle-tmux-macos.md). Linux tarballs
  # don't carry it yet, so Linux keeps the pinned keg — without it a
  # fresh Linux install on a tmux-less box would have no tmux at all.
  on_linux do
    depends_on "h0x91b/dev3/tmux@3.6"
  end
  depends_on "git"
  depends_on "cloudflared"

  def install
    # artifact-template ships in every CLI tarball (create-cli-tarball.sh)
    # and MUST land next to the binary in libexec — the app resolves it at
    # libexec/artifact-template. Without it, launching ANY task fails with
    # "Bundled dev3 artifact template not found".
    libexec.install "dev3", "dist", "artifact-template"
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
