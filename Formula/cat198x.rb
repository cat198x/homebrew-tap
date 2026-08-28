class Cat198x < Formula
  desc "A cross-platform CLI for managing retro gaming ROM collections"
  homepage "https://cat198x.github.io"
  version "0.5.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cat198x/cat198x/releases/download/v0.5.3/cat198x-aarch64-apple-darwin.tar.xz"
      sha256 "2cd3eda9d66060b8961216b98c2a7c4de2be1eb831e15e3bc65cd9b79ed7742f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cat198x/cat198x/releases/download/v0.5.3/cat198x-x86_64-apple-darwin.tar.xz"
      sha256 "42ab873bd7a42b07068193e1bdd4cafca2d8391abe203aeb2b8333405f4d7723"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/cat198x/cat198x/releases/download/v0.5.3/cat198x-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "15e503988c268be90493f43b8c6f6e40f65bf3f2a7ff763febc3fc72011435c4"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
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
