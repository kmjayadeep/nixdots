{ config, pkgs, ... }:

{

  home.packages = with pkgs;
  [
    font-awesome_6  # For Font Awesome 6 Free and Brands used by polybar
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

}

