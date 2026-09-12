class Gnomad < Formula
  desc "A lightweight TUI for managing tinted color schemes in the GNOME shell"
  homepage "https://github.com/GooseRooster/gnomad"
  license "GPL-3.0-or-later"
  version "0.4.4"

  # Runtime dependencies (not managed by Homebrew — must be in PATH):
  #   git — clones/updates the tinted-theming/schemes repo on first run
  depends_on "tinted-theming/tinted/tinty"
  depends_on "gowall"

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/GooseRooster/gnomad/releases/download/v0.4.4/gnomad-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a85cc10cdc7830bd93a8819f1af597e33316eb5eb7a97ab66b316170e987fc61"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/GooseRooster/gnomad/releases/download/v0.4.4/gnomad-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7efd6778cb96c068eb86241753dab7b62f24cc3c173c65f1e980518413055b37"
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
