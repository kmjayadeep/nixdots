{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./bootloader.nix
    ./gui.nix
    ./nixos.nix
    ./packages.nix
    ./ssh.nix
    ./system.nix
  ];

  # Do not touch
  system.stateVersion = "23.05";
}
