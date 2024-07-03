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
    hledger
    immich-cli

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
    libsForQt5.okular
    moonlight-qt # play games over network

    # work
    zoom-us # video calls
    slack

    # Other apps
    neofetch
    restic # for backup
    dig
    btop # Better htop
    nodePackages_latest.http-server
    vlc
    postgresql
    rclone
    hugo
    imagemagick
    # video transcoding
    handbrake

    # programming
    go
    docker-compose
    ripgrep
    jq
    ansible
    kubeseal
  ];
}
