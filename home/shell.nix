{ config, lib, inputs, ... }:

{
  # Enable OMZ
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true
    
    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "z"
        "git"
        "sudo"
        "docker"
        "kubectl"
      ];
    };

    shellAliases = {
      cat = "bat";
      sl = "exa";
      ls = "exa";
      l = "exa -l";
      la = "exa -la";
      ip = "ip --color=auto";
      v = "\${EDITOR:-nvim}";
    };
  };

  # Set neovim as editor
  programs.neovim.defaultEditor = true;
}
