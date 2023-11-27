{ config, lib, inputs, ... }:

  # Enable Oh-my-zsh
  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ 
      "z"
      "git"
      "sudo"
      "docker"
      "kubectl"
      "zsh-syntax-highlighting"
    ];
  };

}
