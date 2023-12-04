{
  config,
  lib,
  inputs,
  ...
}: {
  home.stateVersion = "23.05";

  imports = [
    ./email
    ./hyprland
    ./nvim
    ./swaylock

    ./dunst.nix
    ./env.nix
    ./foot.nix
    ./git.nix
    ./gpg.nix
    ./kubernetes.nix
    ./misc.nix
    ./packages.nix
    ./pass.nix
    ./scripts.nix
    ./shell.nix
    ./syncthing.nix
    ./taskwarrior.nix
    ./theme.nix
    ./waybar.nix
    ./wlogout.nix
  ];
}
