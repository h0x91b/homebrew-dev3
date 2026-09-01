class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.51.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.51.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "f12c1c479a54473077766a6a8be48941d2df4d09ee46f47bded0319de168670b"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.51.0/dev3-cli-macos-x64.tar.gz"
      sha256 "ef4e3f09ed636e593e1e3e0204a6323cd2b1da53c9e26668b1e120aaf00bb826"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.51.0/dev3-cli-linux-x64.tar.gz"
      sha256 "626ba5e067617a83d8722fc6f325b018ffb6da5d52b9f914d220fe010b0e822e"
    end
    on_arm do
        url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.51.0/dev3-cli-linux-arm64.tar.gz"
        sha256 "cd0828e6e410958cdb6e86d602a2f37a8bb91ad0ffef7a0b67dd9e9135ccf78c"
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
