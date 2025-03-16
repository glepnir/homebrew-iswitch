class Iswitch < Formula
  desc "A tool to switch input sources on macOS"
  homepage "https://github.com/glepnir/iswitch"
  license "MIT"
  
  # 自动获取最新版本号
  livecheck do
    url "https://api.github.com/repos/glepnir/iswitch/releases/latest"
    regex(/"tag_name":\s*"v?(\d+(?:\.\d+)+)"/i)
  end
  
  # 如果没有设置 HOMEBREW_ISWITCH_VERSION 环境变量，就获取最新版本
  stable do
    version_tag = ENV["HOMEBREW_ISWITCH_VERSION"] || `curl -s https://api.github.com/repos/glepnir/iswitch/releases/latest | grep -o '"tag_name": "v[^"]*"' | grep -o 'v[^"]*'`.chomp
    version version_tag.gsub(/^v/, "")
    
    url "https://github.com/glepnir/iswitch/releases/download/#{version_tag}/iswitch-#{version_tag}.tar.gz"

    # 跳过校验和检查，因为内容会随版本变化
    sha256 :no_check
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
    assert_match "iSwitch", shell_output("#{bin}/iswitch -h", 0)
  end
end
