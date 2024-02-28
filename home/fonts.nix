{ config, pkgs, ... }:

{

  home.packages = with pkgs;
  [
    font-awesome
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    noto-fonts-color-emoji
  ];

  fonts.fontconfig.enable = true;

}

