{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    eza # better ls
    bat # better cat
    tldr # better man
    fzf # used by kubectx, notes
    wl-clipboard # clipboard
    alejandra # format nix files
    protonmail-bridge # For protonmail

    # GUI apps
    pcmanfm # file manager
    discord
    spotify
    obs-studio # For screen recording
    smplayer
    mpv # dependency for smplayer
    libsForQt5.kdenlive # For video editing
    loupe # Image viewer
    evince # PDF viewer

    # Other apps
    spotify-tui # spotify on terminal
    wlr-randr # xrandr alternative
    way-displays # arandr alternative
    neofetch
    restic # for backup
    dig
    btop # Better htop

    # programming
    go
    docker-compose
    ripgrep
    jq
    ansible
  ];
}
