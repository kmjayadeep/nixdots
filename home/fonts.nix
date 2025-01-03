{ config, pkgs, ... }:

{

  home.packages = with pkgs;
  [
    font-awesome
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

}

