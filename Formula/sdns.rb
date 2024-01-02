# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Sdns < Formula
  desc "Privacy important, fast, recursive dns resolver server with dnssec support"
  homepage "https://sdns.dev"
  version "1.3.6"

  depends_on "go" => :build

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/semihalev/sdns/releases/download/v1.3.6/sdns-1.3.6_darwin_arm64.tar.gz"
      sha256 "2756efa6f218e7271d349eb56660536f4647977fdae41f85e89bc163f6a80420"

      def install
        bin.install "sdns"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/semihalev/sdns/releases/download/v1.3.6/sdns-1.3.6_darwin_amd64.tar.gz"
      sha256 "b28c441a3fe0efc59bb9d5c6708e3767da1bcb54da93601c8eaa1b68903fe66a"

      def install
        bin.install "sdns"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/semihalev/sdns/releases/download/v1.3.6/sdns-1.3.6_linux_armv6.tar.gz"
      sha256 "402180570110c81280367b73efe2fcb9b071523a8811491d2de30fa66dcfc1b9"

      def install
        bin.install "sdns"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/semihalev/sdns/releases/download/v1.3.6/sdns-1.3.6_linux_amd64.tar.gz"
      sha256 "8afa2ad747edd42f9271821dc7643850faba8b93c15522570f978c3193ee9cc7"

      def install
        bin.install "sdns"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/semihalev/sdns/releases/download/v1.3.6/sdns-1.3.6_linux_arm64.tar.gz"
      sha256 "246491b49f667c36c260c71952cd2a5a4aa62a2bf57907817fafd6633b7e9638"

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
