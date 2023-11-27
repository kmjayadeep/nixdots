{ config, lib, inputs, ... }:

{
  home.stateVersion = "23.05";

  imports = [
    ./env.nix
    ./git.nix
    ./gpg.nix
    ./kubernetes.nix
    ./packages.nix
    ./shell.nix
  ];

}
