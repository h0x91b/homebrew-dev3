class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.64.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://releases.h0x91b.com/dev-3.0/v1.64.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "cabdcafce0978edd407a4a17cb372da5b9c977c502711594765456700ada9d9a"
    end
    on_intel do
      url "https://releases.h0x91b.com/dev-3.0/v1.64.0/dev3-cli-macos-x64.tar.gz"
      sha256 "3913d1814f03fbcd6046185e52316db5955cac8ea1e3a82d8552bd9025a3f77c"
    end
  end

  on_linux do
    on_intel do
      url "https://releases.h0x91b.com/dev-3.0/v1.64.0/dev3-cli-linux-x64.tar.gz"
      sha256 "78f40f1cf962137742b5c669f75628826b561e9a898e569244a2d09b864885f4"
    end
    on_arm do
        url "https://releases.h0x91b.com/dev-3.0/v1.64.0/dev3-cli-linux-arm64.tar.gz"
        sha256 "58b9c8fa18fb6f7c462926f20c98af3e243891766e8843cef797c24f039e379b"
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
