class Gnomad < Formula
  desc "A lightweight TUI for managing tinted color schemes in the GNOME shell"
  homepage "https://github.com/GooseRooster/gnomad"
  license "GPL-3.0-or-later"
  version "0.3.3"

  # Runtime dependencies (not managed by Homebrew — must be in PATH):
  #   git    — clones/updates the tinted-theming/schemes repo on first run
  #   tinty  — applies base16/base24 theme changes (brew install tinted-theming/tinted/tinty)
  #   gowall — converts wallpapers to the active colour scheme

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/GooseRooster/gnomad/releases/download/v#{version}/gnomad-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "PLACEHOLDER_X86_64"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/GooseRooster/gnomad/releases/download/v#{version}/gnomad-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "PLACEHOLDER_AARCH64"
    end
  end

  def install
    if OS.linux? && Hardware::CPU.is_64_bit? && (Hardware::CPU.intel? || Hardware::CPU.arm?)
      bin.install "gnomad"
    else
      system "cargo", "install", "--locked", "--root", prefix, "--path", "."
    end
  end

  test do
    assert_match "gnomad #{version}", shell_output("#{bin}/gnomad --version")
  end
end
