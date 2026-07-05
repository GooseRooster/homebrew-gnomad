class Gnomad < Formula
  desc "A lightweight TUI for managing tinted color schemes in the GNOME shell"
  homepage "https://github.com/GooseRooster/gnomad"
  license "GPL-3.0-or-later"
  version "0.3.7"

  # Runtime dependencies (not managed by Homebrew — must be in PATH):
  #   git    — clones/updates the tinted-theming/schemes repo on first run
  #   tinty  — applies base16/base24 theme changes (brew install tinted-theming/tinted/tinty)
  #   gowall — converts wallpapers to the active colour scheme

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/GooseRooster/gnomad/releases/download/v0.3.7/gnomad-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c89411fb4f06e237a466912ec7fc3fc9620a36c632962eec035fc7f58c957830"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/GooseRooster/gnomad/releases/download/v0.3.7/gnomad-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c12c9cf009fd60b03d01aadb780d289b44fb615609c95f52f9c5c3b7a1484239"
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
