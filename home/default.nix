{
  config,
  lib,
  inputs,
  ...
}: {
  home.stateVersion = "23.05";

  imports = [
    ./dunst.nix
    ./env.nix
    ./git.nix
    ./gpg.nix
    ./hyprland.nix
    ./kubernetes.nix
    ./neovim.nix
    ./packages.nix
    ./shell.nix
    ./syncthing.nix
  ];
}
