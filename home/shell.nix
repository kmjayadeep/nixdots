{
  config,
  lib,
  inputs,
  ...
}: {
  # Enable OMZ
  programs.zsh = {
    enable = true;
    dotDir = "${config.home.homeDirectory}/.config/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.path = "${config.home.homeDirectory}/private/zsh/zsh_history";

    oh-my-zsh = {
      enable = true;
      plugins = [
        "z"
        "git"
        "sudo"
        "docker"
        "kubectl"
        "terraform"
      ];
    };

    shellAliases = {
      sl = "eza";
      ls = "eza";
      l = "eza -l --icons";
      la = "eza -la --icons";
      ip = "ip --color=auto";
      v = "\${EDITOR:-nvim}";
      rebuild = "sudo nixos-rebuild switch --flake $NIXOS_CONFIG_DIR --fast; notify-send 'Rebuild complete\!'";
      gameoff = "killall -9 .Discord-wrapped steam dota2 valheim.x86_64";
      t = "task";
      review = "while true; do clear;task in; task today; task backlog; sleep 3; done;";
      sshk = "kitty +kitten ssh";
    };

    # Source additional shell aliases
    # It contains a loop for aliasing k8s commands, thats why it needs to be sourced
    initContent = ''
      source $HOME/.bash_aliases
      export PATH=$PATH:~/.local/bin
    '';
  };

  home.file.".bash_aliases".source = ../assets/bash_aliases;

  # zsh prompt
  programs.starship = {
    enable = true;
    settings = {
      gcloud = {
        disabled = true;
      };
    };
  };

  # Set neovim as editor
  programs.neovim.defaultEditor = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
