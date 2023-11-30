{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./container.nix
    ./fonts.nix
    ./gui.nix
    ./nixos.nix
    ./packages.nix
    ./ssh.nix
    ./steam.nix
    ./system.nix
  ];

  # Do not touch
  system.stateVersion = "23.05";
}
