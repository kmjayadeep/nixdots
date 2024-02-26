{
  config,
  pkgs,
  inputs,
  ...
}: {
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver.windowManager.i3.enable = true;
  
  environment.systemPackages = with pkgs; [
    arandr
    xorg.xrandr # manage monitor
    lxappearance
  ];

  programs.dconf.enable = true;

}
