{
  config,
  lib,
  inputs,
  ...
}: {
  home.stateVersion = "24.11";

  imports = [
    # ./email
    ./i3
    ./kitty
    ./nvim
    ./polybar
    ./rofi
    ./taskwarrior
    ./wlogout

    # ./barrier.nix
    ./backrest.nix
    ./dunst.nix
    ./env.nix
    ./fonts.nix
    ./gcloud.nix
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
    ./xdg.nix
  ];
}
