class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.12.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.12.3/dev3-cli-macos-arm64.tar.gz"
      sha256 "6938c61c1f65e41b80bd8cfd65a4d64fa596533c2ff3aea74a19ec4c8e0e34ca"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.12.3/dev3-cli-macos-x64.tar.gz"
      sha256 "39e35051b84498f557dc5d0a64e2fc2ee2aa1ba93365fa5b459e3e2c8d59fdd7"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.12.3/dev3-cli-linux-x64.tar.gz"
      sha256 "72be082c599cc66a065913f5b6aa28f4102ad78a3e2a9c1f5ae5387bf1b78979"
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
