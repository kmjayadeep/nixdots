{ config, lib, inputs, ... }:

{
  # Enable OMZ
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableAutosuggestions = true;
    
    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "z"
        "git"
        "sudo"
        "docker"
        "kubectl"
        "zsh-syntax-highlighting"
      ];
    }

    shellAliases = {
      cat = "${bat}/bin/bat";
      sl = "exa";
      ls = "exa";
      l = "exa -l";
      la = "exa -la";
      ip = "ip --color=auto";
      v = "\${EDITOR:-nvim}";
    };
  };

}
