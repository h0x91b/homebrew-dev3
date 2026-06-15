class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.21.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.21.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "441e20a00f18369baa8a5cea65581a9ce99340c462f5e48aebeeb9460184ca0d"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.21.0/dev3-cli-macos-x64.tar.gz"
      sha256 "1fdf4d5b5b4d1420ff7e8e9c04e1e99124c3b5680a3cb73f5ca5a873d9a772b9"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.21.0/dev3-cli-linux-x64.tar.gz"
      sha256 "183422b63650445e59fe08c14eadb2607957740b05d62549f427f61f72e65557"
    end
  end

  depends_on "tmux"
  depends_on "git"
  depends_on "cloudflared"

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
