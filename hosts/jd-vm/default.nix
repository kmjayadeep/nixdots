{ config, lib, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./system.nix
    ../modules
  ];

}
