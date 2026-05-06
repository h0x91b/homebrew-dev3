class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.12.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.12.0/dev3-cli-macos-arm64.tar.gz"
      sha256 "5bef64f41e5f5fb2566792c10c926e2f2bbcaccd0b9b1b6f149e4239d1e64a68"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.12.0/dev3-cli-macos-x64.tar.gz"
      sha256 "1e55f639fbcdf3a8103d76897c73d3a1c48dc4b3cac3d9ec899eb937a2f715d1"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.12.0/dev3-cli-linux-x64.tar.gz"
      sha256 "2006db1e19488b2afe47a9d830aa09511bac7518ad0ec4bed615872fbed99da7"
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
