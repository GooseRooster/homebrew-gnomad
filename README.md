# homebrew-gnomad

Homebrew tap for [gnomad](https://github.com/GooseRooster/gnomad) — a lightweight TUI for managing tinted colour schemes and wallpapers in the GNOME shell.

## Install

```sh
brew tap GooseRooster/gnomad
brew install GooseRooster/gnomad/gnomad
```

## Runtime prerequisites

| Tool | Install |
|------|---------|
| `git` | not installed automatically — install via your system package manager |
| `tinty` | installed automatically (hard dependency, from the `tinted-theming/tinted` tap) |
| `gowall` | installed automatically (hard dependency) |

Wallpaper features are opt-in: set `wallpaper_enabled = true` in `~/.config/gnomad/config.toml` to enable them.
