# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Sdns < Formula
  desc "Privacy important, fast, recursive dns resolver server with dnssec support"
  homepage "https://sdns.dev"
  version "1.3.5"

  depends_on "go" => :build

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/semihalev/sdns/releases/download/v1.3.5/sdns-1.3.5_darwin_arm64.tar.gz"
      sha256 "b3995a5013a11b73256326936458f3fb4a33e874ec9e1e2bb76c01aab663cd7a"

      def install
        bin.install "sdns"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/semihalev/sdns/releases/download/v1.3.5/sdns-1.3.5_darwin_amd64.tar.gz"
      sha256 "7648f22f8a212d24909a961fd61c3f274a75084bbf8e48374829b5fe9c603e80"

      def install
        bin.install "sdns"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/semihalev/sdns/releases/download/v1.3.5/sdns-1.3.5_linux_arm64.tar.gz"
      sha256 "a0605c4d9ccebb71f0a118acae0f726878155b4b17b764ba71aa3d1c43d08ab2"

      def install
        bin.install "sdns"
      end
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/semihalev/sdns/releases/download/v1.3.5/sdns-1.3.5_linux_armv6.tar.gz"
      sha256 "84a50cb201bb2fc5e98d2cc39a5cefe77165a5049c4131a0d44c594527161005"

      def install
        bin.install "sdns"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/semihalev/sdns/releases/download/v1.3.5/sdns-1.3.5_linux_amd64.tar.gz"
      sha256 "a993f984849db35ef14843ffc038a202ccbcea65f7621b654d3b2547a5757f08"

      def install
        bin.install "sdns"
      end
    end
  end

  service do
    run [opt_bin / "sdns", "-config", etc / "sdns.conf"]
    keep_alive true
    require_root true
    error_log_path var / "log/sdns.log"
    log_path var / "log/sdns.log"
    working_dir opt_prefix
  end

  test do
    fork do
      exec bin / "sdns", "-config", testpath / "sdns.conf"
    end
    sleep(2)
    assert_predicate testpath / "sdns.conf", :exist?
  end
end
