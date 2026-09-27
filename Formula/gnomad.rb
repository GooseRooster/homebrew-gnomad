class Gnomad < Formula
  desc "A lightweight TUI for managing tinted color schemes in the GNOME shell"
  homepage "https://github.com/GooseRooster/gnomad"
  license "GPL-3.0-or-later"
  version "0.4.5"

  # Runtime dependencies (not managed by Homebrew — must be in PATH):
  #   git — clones/updates the tinted-theming/schemes repo on first run
  depends_on "tinted-theming/tinted/tinty"
  depends_on "gowall"

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/GooseRooster/gnomad/releases/download/v0.4.5/gnomad-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4197a19cdd98b4849608b98cda303038e36c21a74b33ce35847d62dbcdff1c88"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/GooseRooster/gnomad/releases/download/v0.4.5/gnomad-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2a3ea11e6ee95cc18c0c7387614567e7dead35e1962e039686a7d4340577a1e2"
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
