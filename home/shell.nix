{
  config,
  lib,
  inputs,
  ...
}: {
  # Enable OMZ
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

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
      sl = "eza";
      ls = "eza";
      l = "eza -l --icons";
      la = "eza -la --icons";
      ip = "ip --color=auto";
      v = "\${EDITOR:-nvim}";
      rebuild = "sudo nixos-rebuild switch --flake $NIXOS_CONFIG_DIR --fast; notify-send 'Rebuild complete\!'";
    };

    # Source additional bash aliases
    # It contains a loop for aliasing k8s commands, thats why it is separate
    initExtra = ''
      source $HOME/.bash_aliases
    ''

  };

  home.file.".bash_aliases".source = ../assets/bash_aliases;

  # zsh prompt
  programs.starship = {
    enable = true;
  };

  # Set neovim as editor
  programs.neovim.defaultEditor = true;
}
