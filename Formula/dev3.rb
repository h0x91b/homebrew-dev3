class Dev3 < Formula
  desc "Terminal-centric project manager for AI coding agents (CLI + headless)"
  homepage "https://h0x91b.github.io/dev-3.0/"
  version "1.17.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.17.2/dev3-cli-macos-arm64.tar.gz"
      sha256 "5836c4274eb3b7aa893a71468ebe3783421ed6daed14ea25f9ddca2933cbc722"
    end
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.17.2/dev3-cli-macos-x64.tar.gz"
      sha256 "9a639fbc4f352fbf7fe17f730503c90fee63c394a1abff2ddfca84f7616bca5c"
    end
  end

  on_linux do
    on_intel do
      url "https://h0x91b-releases.s3.eu-west-1.amazonaws.com/dev-3.0/v1.17.2/dev3-cli-linux-x64.tar.gz"
      sha256 "6a443b002d21657c6e292cebde9cff03ba141179e1f65b36a9694c931ae2b5da"
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
