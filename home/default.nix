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
    ./foot.nix
    ./git.nix
    ./gpg.nix
    ./hyprland
    ./kubernetes.nix
    ./misc.nix
    ./neovim.nix
    ./packages.nix
    ./pass.nix
    ./shell.nix
    ./syncthing.nix
    ./taskwarrior.nix
    ./theme.nix
    ./waybar.nix
    ./wlogout.nix
  ];
}
