# nixdots
Configuration files for my nixos machines

# Setting up

Run

```
sudo nixos-rebuild switch --flake .#jd-vm --fast
```

# Neovim keymaps

`<Leader>` is space.

## General

| Mode | Key | Action |
| --- | --- | --- |
| normal | `Q` | disabled |
| normal | `<C-n>` | toggle Neo-tree |
| normal | `<C-h/j/k/l>` | move between windows |
| normal | `<Leader><Leader>` | switch to previous buffer |
| normal | `<Leader>sh` | clear search highlight |
| visual | `<C-c>` | copy to system clipboard |
| visual | `<C-x>` | cut to system clipboard |
| visual | `<C-v>` | paste from system clipboard |
| insert | `<C-v>` | paste from system clipboard |

## Telescope

| Mode | Key | Action |
| --- | --- | --- |
| normal | `<C-p>` | find files |
| normal | `<C-g>` | git files |
| normal | `<Leader>l` | buffers |
| normal | `<Leader>st` | live grep |
| normal | `<Leader>sd` | diagnostics |

## Comments

| Mode | Key | Action |
| --- | --- | --- |
| normal/visual | `<Leader>/` | toggle comment with NerdCommenter |

## LSP

These are buffer-local and available when an LSP server is attached.

| Mode | Key | Action |
| --- | --- | --- |
| normal | `<Leader>rn` | rename symbol |
| normal | `<Leader>ca` | code action |
| normal | `gd` | go to definition |
| normal | `gD` | go to declaration |
| normal | `gI` | go to implementation |
| normal | `<Leader>D` | go to type definition |
| normal | `gr` | references in Telescope |
| normal | `<Leader>s` | document symbols in Telescope |
| normal | `<Leader>S` | workspace symbols in Telescope |
| normal | `K` | hover docs |
| command | `:Format` | format current buffer |

Useful built-in diagnostic bindings:

| Mode | Key | Action |
| --- | --- | --- |
| normal | `]d` / `[d` | next / previous diagnostic |
| normal | `<C-w>d` | show diagnostic float under cursor |

## Completion/snippets

Insert/select mode mappings from `nvim-cmp` and `luasnip`.

| Mode | Key | Action |
| --- | --- | --- |
| insert | `<C-n>` / `<C-p>` | next / previous completion item |
| insert | `<C-d>` / `<C-f>` | scroll completion docs up / down |
| insert | `<C-Space>` | open completion menu |
| insert | `<CR>` | confirm completion |
| insert/select | `<Tab>` | next completion item, expand snippet, or jump forward |
| insert/select | `<S-Tab>` | previous completion item or jump backward |

## Plugin defaults worth remembering

| Plugin | Key | Action |
| --- | --- | --- |
| vim-gitgutter | `]c` / `[c` | next / previous git hunk |
| vim-gitgutter | `<Leader>hs` | stage hunk |
| vim-gitgutter | `<Leader>hu` | undo hunk |
| vim-gitgutter | `<Leader>hp` | preview hunk |
| nvim-surround | `ys`, `ds`, `cs` | add, delete, change surround |
| nvim-surround | visual `S` | surround selection |

# TODO

* hyprland config, group styles
* fonts (iosevka?)
* https://github.com/Misterio77/nix-colors
* remove barrier
