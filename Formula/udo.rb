class Udo < Formula
  desc "Task, time and workflow manager for the terminal"
  homepage "https://github.com/jqyDee/udo"
  version "0.1.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jqyDee/udo/releases/download/v0.1.0/udo-aarch64-apple-darwin.tar.xz"
    sha256 "1c704af5e2cc8da7fd2270d5bd027c3a9460eeb342df8a58f440c297ae064424"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jqyDee/udo/releases/download/v0.1.0/udo-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "1247f631b874003803de954c1f49293d1de05ab1c7b3eb999288c552728587b6"
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
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
      bin.install "udo"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "udo"
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
