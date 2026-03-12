# Keymaps Reference

Leader: `Space` | Local leader: `\`

## Essential Vim Motions & Commands

### Movement

| Key | Description |
|-----|-------------|
| `h` `j` `k` `l` | Left, down, up, right |
| `w` `b` | Next word / previous word |
| `e` `ge` | End of word / end of previous word |
| `W` `B` `E` | WORD motions (whitespace-delimited) |
| `0` `$` | Start / end of line |
| `^` | First non-blank character |
| `f{c}` `F{c}` | Jump to next / previous char on line |
| `t{c}` `T{c}` | Jump before next / after previous char |
| `;` `,` | Repeat last `f`/`t` forward / backward |
| `gg` `G` | Top / bottom of file |
| `{` `}` | Previous / next paragraph |
| `%` | Jump to matching bracket |
| `H` `M` `L` | Top / middle / bottom of screen |
| `Ctrl-d` `Ctrl-u` | Half-page down / up |
| `Ctrl-f` `Ctrl-b` | Full page down / up |
| `Ctrl-o` `Ctrl-i` | Jump list back / forward |

### Editing

| Key | Description |
|-----|-------------|
| `i` `a` | Insert before / after cursor |
| `I` `A` | Insert at line start / end |
| `o` `O` | New line below / above |
| `r{c}` | Replace one character |
| `R` | Replace mode |
| `x` | Delete char under cursor |
| `dd` `yy` `cc` | Delete / yank / change line |
| `D` `C` | Delete / change to end of line |
| `J` | Join line below |
| `~` | Toggle case |
| `gu` `gU` | Lowercase / uppercase with motion |
| `.` | Repeat last change |
| `u` `Ctrl-r` | Undo / redo |
| `p` `P` | Paste after / before |
| `"_d` | Delete without yanking |
| `"+y` `"+p` | System clipboard yank / paste |

### Text Objects (use with `d`, `c`, `y`, `v`)

| Key | Description |
|-----|-------------|
| `iw` `aw` | Inner / around word |
| `i"` `a"` | Inner / around quotes |
| `i(` `a(` | Inner / around parens |
| `i{` `a{` | Inner / around braces |
| `i[` `a[` | Inner / around brackets |
| `it` `at` | Inner / around tag |
| `ip` `ap` | Inner / around paragraph |
| `is` `as` | Inner / around sentence |

### Visual Mode

| Key | Description |
|-----|-------------|
| `v` | Character visual |
| `V` | Line visual |
| `Ctrl-v` | Block visual |
| `gv` | Reselect last visual |
| `>` `<` | Indent / unindent selection |
| `=` | Auto-indent selection |

### Search & Substitute

| Key | Description |
|-----|-------------|
| `/pattern` `?pattern` | Search forward / backward |
| `n` `N` | Next / previous match (centered in this config) |
| `*` `#` | Search word under cursor forward / backward |
| `:s/old/new/g` | Substitute in line |
| `:%s/old/new/gc` | Substitute in file with confirm |

### Marks, Registers, Macros

| Key | Description |
|-----|-------------|
| `ma` | Set mark `a` |
| `'a` `` `a `` | Jump to mark `a` |
| `''` | Jump to pre-jump position |
| `"ay` `"ap` | Yank to / paste from register `a` |
| `:reg` | Show registers |
| `qa` | Record macro to register `a` |
| `q` | Stop recording |
| `@a` | Run macro `a` |
| `@@` | Replay last macro |

### Windows & Tabs

| Key | Description |
|-----|-------------|
| `Ctrl-w s` | Horizontal split |
| `Ctrl-w v` | Vertical split |
| `Ctrl-w h/j/k/l` | Move between splits |
| `Ctrl-w =` | Equalize split sizes |
| `Ctrl-w q` | Close split |
| `:tabnew` | New tab |
| `gt` `gT` | Next / previous tab |

## Custom Keymaps

### General (`lua/config/keymaps.lua` + `lua/config/autocmds.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>sp` | n | Toggle spell check |
| `<leader>y` | v | Yank to system clipboard |
| `<leader>x` | v | Cut to system clipboard |
| `<leader>/` | n | Clear search highlight |
| `<leader>t` | n | Open terminal split |
| `<Esc><Esc>` | t | Exit terminal insert mode |
| `<leader>sj` | n | Toggle `j/k` and `gj/gk` |
| `<leader>st` | n | Theme picker |
| `<leader>sr` | n | Search and replace in file |
| `<leader>sq` | n | Search and replace over quickfix |
| `<leader>sc` | n | Convert Markdown buffer to PDF (`:MarkdownToPdf`) |
| `<leader>su` | n | Notebook: toggle Jupytext view auto-handling |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | n | Move across splits |
| `<` `>` | v | Re-indent and keep selection |
| `n` `N` | n | Next/prev search result + center cursor |

### Diagnostics (`lua/config/diagnostics.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>lee` | n | Toggle virtual text |
| `<leader>leu` | n | Toggle diagnostic underline |
| `<leader>li` | n | Toggle inlay hints |
| `<leader>lef` | n | Diagnostic float |
| `]d` `[d` | n | Next / previous diagnostic |
| `]e` `[e` | n | Next / previous error |
| `]w` `[w` | n | Next / previous warning |
| `<leader>leq` | n | Send diagnostics to quickfix |
| `<leader>lel` | n | Send diagnostics to location list |
| `<leader>lD` | n | Browse diagnostics (Telescope fallback to quickfix) |

### LSP + Completion (`lua/plugins/lsp.lua`, `lua/plugins/format.lua`, `lua/plugins/lint.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `gd` `gD` `gy` | n | Go to definition / declaration / type definition |
| `<leader>lf` | n | Format file |
| `<leader>ltc` | n | Toggle completion suggestions |
| `<leader>ll` | n | Run linters |
| `<C-p>` `<C-n>` | i | Previous / next completion item |
| `<C-y>` | i | Confirm completion |
| `<C-Space>` | i | Trigger completion |

### Neo-tree (`lua/plugins/tools.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>nn` | n | Reveal current file in Neo-tree |
| `<leader>nt` | n | Toggle Neo-tree |
| `O` | n | Open file externally (inside Neo-tree window) |

### Notebook (`lua/plugins/tools.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `:JupytextViewToggle` | cmd | Toggle notebook auto-view (Jupytext on/off) for `.ipynb` |

### Telescope (`lua/plugins/telescope.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ff` | n | Find files |
| `<leader>fg` | n | Live grep |
| `<leader>fb` | n | Buffers |
| `<leader>fo` | n | Old files |
| `<leader>fw` | n | Grep word under cursor |
| `<leader>fh` | n | Help tags |
| `<leader>fk` | n | Keymaps |
| `<leader>fc` | n | Commands |
| `<leader>fC` | n | Command history |
| `<leader>fs` | n | Fuzzy search current buffer |
| `<leader>fm` | n | Marks |
| `<leader>fn` | n | Notifications |
| `<leader>fj` | n | Jumplist |
| `<leader>fr` | n | Registers |
| `<leader>ft` | n | Treesitter symbols |
| `<leader>f/` | n | Search history |
| `<leader>fq` | n | Quickfix list |
| `<leader>fl` | n | Location list |
| `<leader>fa` | n | Find files in configured base directories |
| `<leader>fT` | n | TODO comments (TodoTelescope) |
| `<leader>gtc` | n | Git commits |
| `<leader>gts` | n | Git status |
| `<leader>gtB` | n | Git branches |

### Flash + Todo Comments (`lua/plugins/tools.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `s` | n/x/o | Flash jump |
| `S` | n/x/o | Flash Treesitter jump |
| `r` | o | Flash remote |
| `R` | o/x | Flash Treesitter search |
| `]t` `[t` | n | Next / previous TODO comment |

### Treesitter Text Objects (`lua/plugins/treesitter.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `af` `if` | x/o | Function outer / inner |
| `ac` `ic` | x/o | Class outer / inner |
| `aa` `ia` | x/o | Argument outer / inner |
| `ai` `ii` | x/o | Conditional outer / inner |
| `al` `il` | x/o | Loop outer / inner |
| `]m` `[m` | n/x/o | Next / previous function start |
| `]M` `[M` | n/x/o | Next / previous function end |
| `]]` `[[` | n/x/o | Next / previous class start |
| `][` `[]` | n/x/o | Next / previous class end |
| `]a` `[a` | n/x/o | Next / previous argument |
| `<leader>ma` | n | Swap argument with next |
| `<leader>mA` | n | Swap argument with previous |

### Git (`lua/plugins/git.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gp` | n | Preview hunk |
| `<leader>gP` | n | Preview hunk inline |
| `]g` `[g` | n | Next / previous hunk |
| `<leader>gs` | n/v | Stage hunk |
| `<leader>gr` | n/v | Reset hunk |
| `<leader>gS` | n | Stage buffer |
| `<leader>gR` | n | Reset buffer |
| `<leader>gu` | n | Undo stage hunk |
| `<leader>gb` | n | Toggle line blame |
| `<leader>gT` | n | Toggle git signs |
| `ih` | o/x | Select hunk text object |
| `<leader>gg` | n | Open LazyGit |
| `<leader>gdo` | n | Open Diffview |
| `<leader>gdc` | n | Close Diffview |
| `<leader>gdh` | n | Diffview file history (all) |
| `<leader>gdf` | n | Diffview file history (current file) |
| `<leader>gdt` | n | Diffview toggle file panel |
| `<leader>dco` `<leader>dct` `<leader>dcb` `<leader>dca` | n | Diffview conflict choose ours/theirs/base/all |
| `dx` | n | Diffview conflict: delete region |

### Debug / DAP (`lua/plugins/debug.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>dc` | n | Prepare + continue |
| `<leader>dn` `<leader>di` `<leader>do` | n | Step over / into / out |
| `<leader>dC` | n | Run to cursor |
| `<leader>db` | n | Toggle breakpoint |
| `<leader>dB` | n | Conditional breakpoint |
| `<leader>dl` | n | Logpoint |
| `<leader>dh` | n/v | Hover value |
| `<leader>dr` | n | Toggle REPL |
| `<leader>du` | n | Toggle DAP UI |
| `<leader>dq` | n | Terminate session |
| `<leader>ds` | n | Debug nearest Python test |
| `<leader>df` | n | Debug Python test class |
| `<leader>de` | v | Debug selection |
| `<leader>dtj` | n | Toggle `justMyCode` |
| `<leader>dtv` | n | Toggle `.vscode/launch.json` loading |

### Java (`lua/plugins/java.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>jo` | n | Organize imports |
| `<leader>jev` | n/v | Extract variable |
| `<leader>jec` | n/v | Extract constant |
| `<leader>jem` | n/v | Extract method |
| `<leader>jtm` | n | Test nearest method |
| `<leader>jtc` | n | Test class |

### AI (`lua/plugins/ai.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>act` | n | Copilot toggle |
| `<leader>acd` | n | Copilot disable |
| `<leader>ace` | n | Copilot enable |
| `Alt-y` | i | Accept Copilot suggestion |
| `Alt-]` | i | Next suggestion |
| `Alt-[` | i | Previous suggestion |
| `Ctrl-]` | i | Dismiss suggestion |
| `<leader>cc` | n | Toggle CopilotChat |
| `<leader>cf` | v | CopilotChat: fix selection |
| `<leader>cr` | v | CopilotChat: refactor selection |
| `<leader>ce` | v | CopilotChat: explain selection |
| `<leader>ct` | v | CopilotChat: generate tests for selection |
| `<leader>ca` | n/i (chat buffer) | CopilotChat: accept diff |
| `<leader>cd` | n (chat buffer) | CopilotChat: show diff |
| `<leader>cy` | n (chat buffer) | CopilotChat: yank diff |

### Other Tools (`lua/plugins/tools.lua`, `lua/plugins/snippets.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ha` `<leader>hd` `<leader>hh` | n | Harpoon add / remove / menu |
| `<leader>h1` `<leader>h2` `<leader>h3` `<leader>h4` | n | Harpoon jump to slots 1-4 |
| `<leader>hp` `<leader>hn` | n | Harpoon previous / next |
| `<leader>u` | n | Toggle Undotree |
| `<leader>?l` | n | Show buffer-local which-key mappings |
| `<leader>?g` | n | Show global which-key mappings |
| `<leader>ps` `<leader>pS` | n | Surround add / line surround |
| `<leader>pd` `<leader>pc` `<leader>pC` | n | Surround delete / change / change surrounding |
| `<leader>ps` | v | Surround add (visual) |
| `<leader>mm` | n | Toggle Markview |
| `<leader>mf` `<leader>mF` | n | Mkdnflow follow / destroy link |
| `<leader>mc` `<leader>mC` | n/v | Mkdnflow create link / from clipboard |
| `<leader>mn` `<leader>mp` | n | Mkdnflow next / previous link |
| `<leader>mb` `<leader>mB` | n | Mkdnflow back / forward |
| `<leader>mt` | n/v | Mkdnflow toggle todo |
| `<C-j>` `<C-k>` | i/s | LuaSnip expand-or-jump / jump back |

## Which-key Groups

| Prefix | Group |
|--------|-------|
| `<leader>a` | ai |
| `<leader>d` | debug |
| `<leader>f` | find |
| `<leader>g` | git |
| `<leader>h` | harpoon |
| `<leader>j` | java |
| `<leader>l` | lsp |
| `<leader>m` | markdown |
| `<leader>n` | neo-tree |
| `<leader>p` | pairs/surround |
| `<leader>s` | settings |
| `<leader>w` | windows (group label present; plugin disabled) |
| `<leader>?` | whichkey |
