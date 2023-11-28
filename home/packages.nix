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

    # apps
    spotify-tui # spotify on terminal
    docker-compose

    # programming
    go
  ];
}
