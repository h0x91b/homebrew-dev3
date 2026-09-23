class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.55.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.55.2/dev3-cli-macos-arm64.tar.gz"
      sha256 "cbe010f9842c0b0dc25f5f21286f6c94338f421dd2b352ca786bdf9b21be3d51"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.55.2/dev3-cli-macos-x64.tar.gz"
      sha256 "00ecd08c96b18a9d6e56e57ce2f58e1d4a044fd8063833bc5c64da2852add914"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.55.2/dev3-cli-linux-x64.tar.gz"
      sha256 "df1b6c3e0b9ddd52be7eb242efde5f4af048788d521a4fe5eb84a8cdf415a04c"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.55.2/dev3-cli-linux-arm64.tar.gz"
        sha256 "fe038f4ed45a365413ebc6b4cdffb9b2656ccc9b10701f7ae706f49bb142249e"
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
