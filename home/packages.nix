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
    loupe # Image viewer
    evince # PDF viewer
    jellyfin-media-player
    gimp
    code-cursor # Ai editor
    cursor-cli # Cli for cursor.com
    opencode

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
    jellyfin-media-player
    protonmail-desktop

    # programming
    go
    docker-compose
    ripgrep
    jq
    ansible
    kubeseal
    httpie
    terraform
    coder
    just
    rustup
    gccgo
    nodejs_22
    yarn
    nodePackages_latest.vercel
    devenv
    mongosh
    gemini-cli
    monero-gui
  ];
}
