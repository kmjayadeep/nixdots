{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  # TODO: Move to https://github.com/nix-community/nixvim

  programs.neovim = let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      gopls
      wl-clipboard
      rnix-lsp
    ];

    plugins = with pkgs.vimPlugins; [

      # File manager on the left
      {
        plugin = neo-tree-nvim;
        config = toLuaFile ./plugin/neotree.lua;
      }
      nvim-web-devicons # Icons for file manager

      # LSP
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./plugin/lsp.lua;
      }

      # Autocomplete
      {
        plugin = nvim-cmp;
        config = toLuaFile ./plugin/cmp.lua;
      }

      # Comment toggle with shortcuts
      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      }

      # Theme
      # More catppuccin flavors in https://github.com/catppuccin/nvim/
      {
        plugin = catppuccin-nvim;
        config = "colorscheme catppuccin";
      }

      # File opener, git files, fuzzy search etc
      {
        plugin = telescope-nvim;
        config = toLuaFile ./plugin/telescope.lua;
      }
      telescope-fzf-native-nvim # Required for telescope to search files

      cmp_luasnip
      cmp-nvim-lsp

      luasnip
      friendly-snippets

      # Status line
      {
        plugin = lualine-nvim;
        config = toLua "require(\"lualine\").setup()";
      }

      nerdcommenter
      vim-gitgutter

      # For auto closing ( { etc
      {
        plugin = autoclose-nvim;
        config = toLua "require(\"autoclose\").setup()";
      }

      # For select/delete/change around { ( tags etc
      {
        plugin = nvim-surround;
        config = toLua "require(\"nvim-surround\").setup()";
      }

      {
        plugin = nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-json
        ]);
        config = toLuaFile ./plugin/treesitter.lua;
      }

      # Make indentation more visible
      {
        plugin = indent-blankline-nvim;
        config = toLuaFile ./plugin/ibl.lua;
      }

      vim-nix
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
      ${builtins.readFile ./binds.lua}
    '';
  };
}
