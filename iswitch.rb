class Iswitch < Formula
  desc "A tool to switch input sources on macOS"
  homepage "https://github.com/glepnir/iswitch"
  url "https://github.com/glepnir/iswitch/releases/latest/download/iswitch-macos.tar.gz"
  license "MIT"

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
    system "#{bin}/iswitch", "-h"
  end

  livecheck do
    url :stable
    strategy :github_latest
  end
end
