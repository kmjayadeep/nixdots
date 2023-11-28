{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./container.nix
    ./gui.nix
    ./nixos.nix
    ./packages.nix
    ./ssh.nix
    ./system.nix
  ];

  # Do not touch
  system.stateVersion = "23.05";
}
