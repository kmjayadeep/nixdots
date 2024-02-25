{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {

  home.file.".config/i3/config".source = ./config;

  home.file.".config/i3/wall.jpg" = {
    source = ./wall.jpg;
  };

  home.packages = with pkgs; [
    rofi # app launcher
    nitrogen # for wallpaper
    flameshot # screenshot
    pasystray # pulseaudio volume tray
    acpilight # backlight and keyboard light
    playerctl # media controls
    dex # autoluanch desktopentry files
    xss-lock # lock automatically on suspend, screensaver
    xsecurelock # better lock than xlock
    autorandr # also install from apt to setup systemd service
  ];

}
