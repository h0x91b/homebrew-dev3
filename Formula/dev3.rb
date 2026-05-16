class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.13.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.13.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "8198ab99df858cde97b49db9486b34375fda1a53988d0b2eb4092ae3ddaf9460"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.13.0/dev3-cli-macos-x64.tar.gz"
      sha256 "62934cd817b4d49a1d6320d128bffc23f846321a9bd845fd63b8f9f49d15f7ee"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.13.0/dev3-cli-linux-x64.tar.gz"
      sha256 "ada00edcdb011dc7b257786ac2a434e2089c7821462cdefca56b5fbc09d237ec"
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
