{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    # Core system modules
    ./nixos.nix
    ./system.nix
    ./packages.nix
    ./fonts.nix

    # Desktop environment
    ./i3.nix
    # NOTE: Uncomment below for alternative DEs when needed
    # ./gnome.nix
    # ./hyprland.nix
    # ./sway.nix

    # Services and features
    ./android.nix
    ./container.nix
    ./nfs.nix
    ./samba.nix
    ./ssh.nix
    ./steam.nix
  ];

  # Do not touch
  system.stateVersion = "24.11";


  # TODO: Find a solution
  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];
}
