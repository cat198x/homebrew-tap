class Cat198x < Formula
  desc "A cross-platform CLI for managing retro gaming ROM collections"
  homepage "https://cat198x.github.io"
  version "0.5.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cat198x/cat198x/releases/download/v0.5.7/cat198x-aarch64-apple-darwin.tar.xz"
      sha256 "0c6889384fba20d0f36d54fcdcad521ea1049ed3b5e2d292805cbc580ae667ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cat198x/cat198x/releases/download/v0.5.7/cat198x-x86_64-apple-darwin.tar.xz"
      sha256 "41a96612fd61c33cb370b74b8de1b426fc438231395f1520eacaffcb469f005f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/cat198x/cat198x/releases/download/v0.5.7/cat198x-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3934c92f99cd93c7fd731864d73c4aa44f117566314209a17fa46f9bc9b55957"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cat198x/cat198x/releases/download/v0.5.7/cat198x-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dcda271cd0b2275ef92b6465366a87184a6f1035b487c17c40c0c2e1875bdb6e"
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
