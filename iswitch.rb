class Iswitch < Formula
  desc "A tool to switch input sources on macOS"
  homepage "https://github.com/glepnir/iswitch"
  url "https://github.com/glepnir/iswitch/releases/latest/download/iswitch-macos.tar.gz"
  license "MIT"

  def install
    bin.install "iswitch"
  end

  test do
    system "#{bin}/iswitch", "-h"
  end

  livecheck do
    url :stable
    strategy :github_latest
  end
end
