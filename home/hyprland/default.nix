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

  # home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      ${builtins.readFile ./hyprland.conf}
    '';
  };

  # enable automounting disks
  services.udiskie.enable = true;
  services.udiskie.tray = "never"; # tray doesn't work in wayland yet
}
