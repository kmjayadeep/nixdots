{
  pkgs,
  lib,
  inputs,
  ...
}: {

  programs.rofi =  {
    enable = true;
    theme = "nord";
  };

  home.file.".local/share/rofi/themes/nord.rasi".source = ./theme-nord.rasi;

}
