{
  config,
  lib,
  inputs,
  ...
}: {
  home.stateVersion = "23.05";

  imports = [
    ./email
    ./i3
    ./kitty
    ./nvim
    ./polybar
    ./rofi
    ./taskwarrior
    ./wlogout

    ./barrier.nix
    ./dunst.nix
    ./env.nix
    ./fonts.nix
    ./git.nix
    ./gpg.nix
    ./hidpi.nix
    ./kubernetes.nix
    ./ledger.nix
    ./misc.nix
    ./packages.nix
    ./pass.nix
    ./rbw.nix
    ./scripts.nix
    ./shell.nix
    ./syncthing.nix
    ./theme.nix
    ./timers.nix
    ./xdg.nix
  ];
}
