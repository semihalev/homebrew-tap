# This file was generated by GoReleaser. DO NOT EDIT.
class Sdns < Formula
  desc "Privacy important, fast, recursive dns resolver server with dnssec support"
  homepage "https://sdns.dev"
  version "1.1.6"
  bottle :unneeded

  if OS.mac?
    url "https://github.com/semihalev/sdns/releases/download/v1.1.6/sdns-1.1.6_darwin_amd64.tar.gz"
    sha256 "19b8fd6f613f9a271baed69b6c16426257f9e583fa9ece0ca75558bd9aa0748b"
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/semihalev/sdns/releases/download/v1.1.6/sdns-1.1.6_linux_amd64.tar.gz"
      sha256 "1dc4f70eb2b793fa43681222cc922fbbe8557239ce769a14c25697b6a6e75c52"
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/semihalev/sdns/releases/download/v1.1.6/sdns-1.1.6_linux_arm64.tar.gz"
        sha256 "c428a12eca55268227e4f72be9acd914b965eced4a716b83de5c469d1fe09429"
      else
        url "https://github.com/semihalev/sdns/releases/download/v1.1.6/sdns-1.1.6_linux_armv6.tar.gz"
        sha256 "397a365413f4cb9b43177f07686004bd067016f17e1f13978004a343134da83f"
      end
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
