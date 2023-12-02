{
  pkgs,
  lib,
  inputs,
  ...
}: {
  # hyprland is already installed at system level, this module configures it
  home.packages = with pkgs; [
    # for wallpaper
    swaybg
    rofi-wayland
    waybar
  ];

  home.file.".config/hypr/hyprland.conf".source = ../assets/hyprland.conf;

  # enable automounting disks
  services.udiskie.enable = true;
}
