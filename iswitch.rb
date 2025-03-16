class Iswitch < Formula
  desc "A tool to switch input sources on macOS"
  homepage "https://github.com/glepnir/iswitch"
  license "MIT"
  latest_version_tag = `curl -s https://api.github.com/repos/glepnir/iswitch/releases/latest | grep -o '"tag_name": "v[^"]*"' | grep -o 'v[^"]*'`.chomp
  version latest_version_tag.gsub(/^v/, "")
  url "https://github.com/glepnir/iswitch/releases/download/#{latest_version_tag}/iswitch-#{latest_version_tag}.tar.gz"
  calculated_sha256 = `curl -sL "https://github.com/glepnir/iswitch/releases/download/#{latest_version_tag}/iswitch-#{latest_version_tag}.tar.gz" | shasum -a 256 | awk '{print $1}'`.chomp
  if !calculated_sha256.empty?
    sha256 calculated_sha256
  else
    sha256 "f4502deeb0601e51d78c8c60563a555406409e392a8892b32d5843e37a444b9d"
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
