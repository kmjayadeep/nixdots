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
    arandr

    # Other apps
    spotify-tui # spotify on terminal

    # programming
    go
    docker-compose
  ];
}
