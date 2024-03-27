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
    unzip
    tree
    tmux
    python3

    # GUI apps
    pcmanfm # file manager
    xarchiver # extract archives in pcmanfm
    discord
    spotify
    obs-studio # For screen recording
    smplayer
    mpv # dependency for smplayer
    libsForQt5.kdenlive # For video editing
    loupe # Image viewer
    evince # PDF viewer
    thunderbird-bin # email client

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
