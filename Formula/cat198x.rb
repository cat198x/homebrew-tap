class Cat198x < Formula
  desc "A cross-platform CLI for managing retro gaming ROM collections"
  homepage "https://cat198x.github.io"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cat198x/cat198x/releases/download/v0.5.2/cat198x-aarch64-apple-darwin.tar.xz"
      sha256 "5a9f86c43624bd132afe9aef1038e34c24f20bfe95ad997af7e87c097af369bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cat198x/cat198x/releases/download/v0.5.2/cat198x-x86_64-apple-darwin.tar.xz"
      sha256 "a4d70da3a6410a760651ee4a8322523c02cb0acea6c58d492aeedbc389c3529e"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/cat198x/cat198x/releases/download/v0.5.2/cat198x-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "a7661a30a16d81b1f2af5481094be60b15d77de89f7c45370bd415e1b9002072"
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
