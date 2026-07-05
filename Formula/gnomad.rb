class Gnomad < Formula
  desc "A lightweight TUI for managing tinted color schemes in the GNOME shell"
  homepage "https://github.com/GooseRooster/gnomad"
  license "GPL-3.0-or-later"
  version "0.3.6"

  # Runtime dependencies (not managed by Homebrew — must be in PATH):
  #   git    — clones/updates the tinted-theming/schemes repo on first run
  #   tinty  — applies base16/base24 theme changes (brew install tinted-theming/tinted/tinty)
  #   gowall — converts wallpapers to the active colour scheme

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/GooseRooster/gnomad/releases/download/v0.3.6/gnomad-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2b333d896de6bab55b99913a4c9d0886c5f624fce049770a556694f646d7218d"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/GooseRooster/gnomad/releases/download/v0.3.6/gnomad-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f427e36a92ee4c106cdcf10c8a4e6b3d5c2a210c2074c01baaa1524003c4efee"
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
