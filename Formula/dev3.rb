class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.15.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.15.2/dev3-cli-macos-arm64.tar.gz"
      sha256 "1855832cb6c3da42b446204afa3f4513ad0c814afb4255aca9bed6a96e79c786"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.15.2/dev3-cli-macos-x64.tar.gz"
      sha256 "e01f6ff868e88148674d2d0dca6bc7fd4e03c7f505debdf9f714a314f2cafc1c"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.15.2/dev3-cli-linux-x64.tar.gz"
      sha256 "2b6d1e7d67c3c92d5436d2983c6e8b23c5997b9a5d46d23ad4262cb0977f32c3"
    end
  end

  depends_on "tmux"
  depends_on "git"

  def install
    libexec.install "dev3", "dev3-server", "dist"
    chmod 0755, libexec/"dev3"
    chmod 0755, libexec/"dev3-server"
    # Only link `dev3`. The compiled `dev3-server` is spawned by
    # `dev3` via realpath(execPath)/dev3-server, so it finds itself
    # next to the real binary in libexec.
    bin.install_symlink libexec/"dev3"
  end

  test do
    assert_match "dev3", shell_output("#{bin}/dev3 --version")
  end
end
