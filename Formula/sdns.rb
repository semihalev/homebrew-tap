# This file was generated by GoReleaser. DO NOT EDIT.
class Sdns < Formula
  desc "Privacy important, fast, recursive dns resolver server with dnssec support"
  homepage "https://sdns.dev"
  version "1.1.7"
  bottle :unneeded

  if OS.mac?
    url "https://github.com/semihalev/sdns/releases/download/v1.1.7/sdns-1.1.7_darwin_amd64.tar.gz"
    sha256 "3d701477dbd1af1e9b85e8e856a8c4ec16c203fa61bbf95adac3441e47bd4035"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/semihalev/sdns/releases/download/v1.1.7/sdns-1.1.7_linux_amd64.tar.gz"
    sha256 "949be3d8fc44b94a00e163a61b97318f71bb508ccc046c901e5f27432272a3d9"
  end
  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://github.com/semihalev/sdns/releases/download/v1.1.7/sdns-1.1.7_linux_armv6.tar.gz"
    sha256 "62090afaa4b459ef58970cd1239c10e3f7b2da04f3dc796e05e4a41bd2a17cb7"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/semihalev/sdns/releases/download/v1.1.7/sdns-1.1.7_linux_arm64.tar.gz"
    sha256 "86422be5ff9c3499d142accea78023f4035f632a3c8b9d9001fe5cd1b0041ee1"
  end

  depends_on "go" => :build

  def install; end

  plist_options startup: false

  def plist
    <<~EOS
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
      #{'      '}
    EOS
  end

  test do
    fork do
      exec bin / "sdns", "-config", testpath / "sdns.conf"
    end
    sleep(2)
    assert_predicate testpath / "sdns.conf", :exist?
  end
end
