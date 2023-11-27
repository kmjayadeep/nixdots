{ inputs, pkgs, config, ... }:

{
  imports = [
    ./bootloader.nix
    ./gui.nix
    ./nixos.nix
    ./packages.nix
    ./system.nix
  ];

  # Do not touch
  system.stateVersion = "23.05";
}
