{ config, lib, inputs, ... }:

{
  home.stateVersion = "23.05";

  imports = [
    ./git.nix
    ./gpg.nix
  ];

}
