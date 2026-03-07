# Kitty Configuration

A shared Kitty setup for macOS and Linux. Main config lives in `kitty/kitty.conf`, with the active color theme in `kitty/current-theme.conf`.

## Structure

- `kitty/kitty.conf`: core terminal behavior, font setup, and optional visual tweaks
- `kitty/current-theme.conf`: currently selected theme values (included from `kitty.conf`)

## Active Theme

- Theme: **Catppuccin Mocha**
- Loaded via:

```conf
include current-theme.conf
```

The theme include is wrapped by markers in `kitty/kitty.conf`:

- `# BEGIN_KITTY_THEME`
- `# END_KITTY_THEME`

## Font

Configured font family:

```conf
font_family      family="JetBrains Mono"
bold_font        auto
italic_font      auto
bold_italic_font auto
```

## Behavior

- Audio bell is disabled (`enable_audio_bell no`)
- GPU/background tuning and opacity options are present but commented out for optional use

## Platform Notes

No platform-specific branches in the Kitty config itself; the same files are linked on both macOS and Linux by `install.sh`.
