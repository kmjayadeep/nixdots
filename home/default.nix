{ config, lib, inputs, ... }:

{
  home.stateVersion = "23.05";

  imports = [
    ./git.nix
    ./gpg.nix
    ./kubernetes.nix
    ./shell.nix
  ];

}
