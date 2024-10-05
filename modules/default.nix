{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./container.nix
    ./fonts.nix
    # ./gnome.nix # testing
    # ./hyprland.nix # not used now
    # ./sway.nix
    ./i3.nix
    ./nfs.nix
    ./nixos.nix
    ./packages.nix
    ./samba.nix
    ./ssh.nix
    ./steam.nix
    ./system.nix
  ];

  # Do not touch
  system.stateVersion = "23.05";
}
