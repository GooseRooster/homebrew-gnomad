class Gnomad < Formula
  desc "A lightweight TUI for managing tinted color schemes in the GNOME shell"
  homepage "https://github.com/GooseRooster/gnomad"
  license "GPL-3.0-or-later"
  version "0.4.6"

  # Runtime dependencies (not managed by Homebrew — must be in PATH):
  #   git — clones/updates the tinted-theming/schemes repo on first run
  depends_on "tinted-theming/tinted/tinty"
  depends_on "gowall"

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/GooseRooster/gnomad/releases/download/v0.4.6/gnomad-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8212756519e5eb648968667a7a3187144feb38a4cd344689f24460600df9bc24"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/GooseRooster/gnomad/releases/download/v0.4.6/gnomad-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e37e85e0abcf4867030bebe04ab3c0452504e6353e0264cd57a9a1978914eb68"
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
