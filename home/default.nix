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
    ./nvim
    ./polybar
    ./swaylock
    ./taskwarrior
    ./wofi

    ./dunst.nix
    ./env.nix
    ./fonts.nix
    ./git.nix
    ./gpg.nix
    ./kubernetes.nix
    ./misc.nix
    ./packages.nix
    ./pass.nix
    ./rbw.nix
    ./scripts.nix
    ./shell.nix
    ./syncthing.nix
    ./theme.nix
    ./timers.nix
    ./wlogout.nix
    ./xdg.nix
  ];
}
