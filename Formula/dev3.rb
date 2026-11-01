class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.62.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://releases.h0x91b.com/dev-3.0/v1.62.2/dev3-cli-macos-arm64.tar.gz"
      sha256 "271026f40bdb3594201fead2817d2b0725234f6c1c628275548cfd80a05b48ef"
    end
    on_intel do
      url "https://releases.h0x91b.com/dev-3.0/v1.62.2/dev3-cli-macos-x64.tar.gz"
      sha256 "979b66b27b3601761c790d9bbf83c31ef09fa6193a8d6c969d89a9112d3b3feb"
    end
  end

  on_linux do
    on_intel do
      url "https://releases.h0x91b.com/dev-3.0/v1.62.2/dev3-cli-linux-x64.tar.gz"
      sha256 "aa62af3610727a1f979155e7768202625bc70036c4a93ad85c1c63fb16c5d69c"
    end
    on_arm do
        url "https://releases.h0x91b.com/dev-3.0/v1.62.2/dev3-cli-linux-arm64.tar.gz"
        sha256 "9a9db2c17a80fc38e25cc95276780bec226e4fce2db5e20b46b88d80759ae00a"
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
