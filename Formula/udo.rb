class Udo < Formula
  desc "Task, time and workflow manager for the terminal"
  homepage "https://github.com/jqyDee/udo"
  version "0.5.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jqyDee/udo/releases/download/v0.5.1/udo-aarch64-apple-darwin.tar.xz"
    sha256 "acbc86fb951aa3e57986c29ed96201f59abebddc03dac3bd62f53f9aa01d7946"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jqyDee/udo/releases/download/v0.5.1/udo-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "1071d7d044ba5f36f97620489f53c13f750060f8c67f6433a2b2a649b0b440eb"
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
