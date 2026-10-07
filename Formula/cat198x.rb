class Cat198x < Formula
  desc "A cross-platform CLI for managing retro gaming ROM collections"
  homepage "https://cat198x.github.io"
  version "0.5.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cat198x/cat198x/releases/download/v0.5.4/cat198x-aarch64-apple-darwin.tar.xz"
      sha256 "2296a3e4a9f20c0ca1c80ea162c1d6d1c17b31b12ddab269f4d4a8de3f6e55b3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cat198x/cat198x/releases/download/v0.5.4/cat198x-x86_64-apple-darwin.tar.xz"
      sha256 "baf9041a34b88e7b666edfddea75e4d5494f29b6188db0dc9f2fe138de976970"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/cat198x/cat198x/releases/download/v0.5.4/cat198x-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "404aab48d7ce8c03f95f53add0f63f01992918d8ef96cab3aca2d8df66fd3527"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cat198x/cat198x/releases/download/v0.5.4/cat198x-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6ea4315fb79be0cd424cdf15fa731d69c5a8e3febb05e53793714f10f00e743d"
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
