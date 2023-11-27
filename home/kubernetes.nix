{ config, lib, inputs, ... }:

{

  home.packages =  with pkgs; [
    kubectl
    k9s
  ];

}
