# Terminal Emulators

Two terminal emulators are configured: **Ghostty** (primary) and **Kitty** (alternative). Both are installed via Homebrew and linked by `install.sh`.

---

## Ghostty

Config: `ghostty/config`

Ghostty is the primary terminal. Minimal config — relies on Ghostty defaults.

```conf
theme = GitHub Dark Default
font-family = JetBrains Mono
font-size = 13
```

---

## Kitty

Config: `kitty/kitty.conf` + `kitty/current-theme.conf`

Kitty is kept as an alternative. Main config includes the theme via:

```conf
include current-theme.conf
```

### Theme

**Adwaita Dark** — a dark theme based on the GNOME Adwaita palette.

Colors are defined in `kitty/current-theme.conf`:

| Element | Color |
|---------|-------|
| Background | `#1d1d20` |
| Foreground | `#deddda` |
| Cursor | `#deddda` |
| Active tab bg | `#242424` |
| Inactive tab bg | `#303030` |

### Font

```conf
font_family      family="JetBrains Mono"
bold_font        auto
italic_font      auto
bold_italic_font auto
```

### Behavior

- Audio bell disabled (`enable_audio_bell no`)

---

## AeroSpace Terminal Launch

`Alt + Enter` opens the default terminal. Currently configured to launch Ghostty:

```toml
alt-enter = "exec-and-forget open -a 'ghostty'"
```
