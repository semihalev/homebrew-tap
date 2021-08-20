# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Sdns < Formula
  desc "Privacy important, fast, recursive dns resolver server with dnssec support"
  homepage "https://sdns.dev"
  version "1.1.8"
  bottle :unneeded

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/semihalev/sdns/releases/download/v1.1.8/sdns-1.1.8_darwin_amd64.tar.gz"
      sha256 "d2e355422afa6ceedaa57d7f81ea5e298c64d73b280895d4f5acfbcd41e83a90"
    end
    if Hardware::CPU.arm?
      url "https://github.com/semihalev/sdns/releases/download/v1.1.8/sdns-1.1.8_darwin_arm64.tar.gz"
      sha256 "aeb8176b9bb28969a0dad7103bf4b818580d400c6ad2525d2ec1ed840a50747f"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/semihalev/sdns/releases/download/v1.1.8/sdns-1.1.8_linux_amd64.tar.gz"
      sha256 "585635d17a73563779c5ab52f7f337469de080f7a6b562b6cc99be6cd5f40cf8"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/semihalev/sdns/releases/download/v1.1.8/sdns-1.1.8_linux_armv6.tar.gz"
      sha256 "8770031795b3ebbe13e19c47a5c6f5bd21ee6a9ae5702b9313b7645bee4e7456"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/semihalev/sdns/releases/download/v1.1.8/sdns-1.1.8_linux_arm64.tar.gz"
      sha256 "3c6ca98a2a07bf4581db55cdbe7eed56f173040bb2e697e3824496888395cf16"
    end
  end

  depends_on "go" => :build

  def install
    bin.install "sdns"
  end

  plist_options :startup => false

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>#{plist_name}</string>
    <key>ProgramArguments</key>
    <array>
      <string>#{opt_bin}/sdns</string>
      <string>-config</string>
      <string>#{etc}/sdns.conf</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardErrorPath</key>
    <string>#{var}/log/sdns.log</string>
    <key>StandardOutPath</key>
    <string>#{var}/log/sdns.log</string>
    <key>WorkingDirectory</key>
    <string>#{opt_prefix}</string>
  </dict>
</plist>

  EOS
  end

  test do
    fork do
      exec bin/"sdns", "-config", testpath/"sdns.conf"
    end
    sleep(2)
    assert_predicate testpath/"sdns.conf", :exist?
  end
end
