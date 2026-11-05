class Gnomad < Formula
  desc "A lightweight TUI for managing tinted color schemes in the GNOME shell"
  homepage "https://github.com/GooseRooster/gnomad"
  license "GPL-3.0-or-later"
  version "0.5.1"

  # Runtime dependencies (not managed by Homebrew — must be in PATH):
  #   git — clones/updates the tinted-theming/schemes repo on first run
  depends_on "tinted-theming/tinted/tinty"
  depends_on "gowall"

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/GooseRooster/gnomad/releases/download/v0.5.1/gnomad-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "53b4442423be425d635c26afac8ccfd732b1d9314e1e77fb6efbb323fe53f220"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/GooseRooster/gnomad/releases/download/v0.5.1/gnomad-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4d925e3dd36c6241fa6861eb2fdd885e4b4b2ad2edd98f3748cd9855c17ed5df"
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
