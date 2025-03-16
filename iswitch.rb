class Iswitch < Formula
  desc "A tool to switch input sources on macOS"
  homepage "https://github.com/glepnir/iswitch"
  url "https://github.com/glepnir/iswitch/releases/latest/download/iswitch.tar.gz"
  version :head  # Special version designation that tells Homebrew this is always the latest
  sha256 :no_check  # Skip checksum verification since we're using "latest"
  license "MIT"

  # Add head to allow installation from GitHub source
  head do
    url "https://github.com/glepnir/iswitch.git", branch: "main"
  end

  def install
    bin.install "iswitch"
  end

  service do
    run [opt_bin/"iswitch"]
    keep_alive true
    log_path var/"log/iswitch.log"
    error_log_path var/"log/iswitch.log"
    working_dir HOMEBREW_PREFIX
  end

  test do
    # Test help output
    assert_match "iSwitch", shell_output("#{bin}/iswitch -h", 0)

    # Test listing input sources (this might fail if run in CI without a GUI)
    # so we make it optional with the true || part
    system "#{bin}/iswitch", "-p" or true
  end

  # Disable livecheck since we're always using the latest version
  livecheck do
    skip "Uses latest version"
  end
end
