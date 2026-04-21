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

Theme: **Adwaita Dark**. Font: **JetBrains Mono**. Audio bell disabled.

---

## AeroSpace Terminal Launch

`Alt + Enter` opens the default terminal. Currently configured to launch Ghostty:

```toml
alt-enter = "exec-and-forget open -a 'ghostty'"
```
