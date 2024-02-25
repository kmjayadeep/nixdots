{ config, pkgs, ... }:

{

  home.packages = with pkgs;
  [
    font-awesome
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  fonts.fontconfig.enable = true;

}

