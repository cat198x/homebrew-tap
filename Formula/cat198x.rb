class Cat198x < Formula
  desc "A cross-platform CLI for managing retro gaming ROM collections"
  homepage "https://cat198x.github.io"
  version "0.5.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cat198x/cat198x/releases/download/v0.5.6/cat198x-aarch64-apple-darwin.tar.xz"
      sha256 "655fd1a4a8468c93463a7ed722db8ebc92ca6bc2ace5b3c94814434c5a2cc59a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cat198x/cat198x/releases/download/v0.5.6/cat198x-x86_64-apple-darwin.tar.xz"
      sha256 "3b67618e07fde48267a79d6b3f97cc6c8c70f81298e8bfcc0716a683a2209023"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/cat198x/cat198x/releases/download/v0.5.6/cat198x-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3241f55a05b93ef1379baff0765d1592575c582db86a319ac9b5bf90767fb025"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cat198x/cat198x/releases/download/v0.5.6/cat198x-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ff6ad90c2a4c6946996dd90c03370ffbb152e9edd7a7ee185def31ed48813552"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cat198x"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cat198x"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cat198x"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cat198x"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
