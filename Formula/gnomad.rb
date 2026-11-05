class Gnomad < Formula
  desc "A lightweight TUI for managing tinted color schemes in the GNOME shell"
  homepage "https://github.com/GooseRooster/gnomad"
  license "GPL-3.0-or-later"
  version "0.6.0"

  # Runtime dependencies (not managed by Homebrew — must be in PATH):
  #   git — clones/updates the tinted-theming/schemes repo on first run
  depends_on "tinted-theming/tinted/tinty"
  depends_on "gowall"

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/GooseRooster/gnomad/releases/download/v0.6.0/gnomad-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3b283c0d45b2f23af52a4a49f9980f2a918edbe3cf873c6b9cbc01a81c7f2dfd"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/GooseRooster/gnomad/releases/download/v0.6.0/gnomad-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "aeaa604a1e5642ff54888b075f3ce163d2ac45d173ff371fbe0f881e49bfea8a"
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
