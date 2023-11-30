{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    eza # better ls
    bat # better cat
    tldr # better man

    alejandra # format nix files

    # GUI apps
    pcmanfm # file manager
    discord
    spotify
    obs-studio # For screen recording

    # Other apps
    spotify-tui # spotify on terminal
    wlr-randr # xrandr alternative
    way-displays # arandr alternative

    # programming
    go
    docker-compose
  ];
}
