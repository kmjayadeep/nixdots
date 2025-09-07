{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./android.nix
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
  system.stateVersion = "24.11";

  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];
}
