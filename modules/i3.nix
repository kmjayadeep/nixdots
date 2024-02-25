{
  config,
  pkgs,
  inputs,
  ...
}: {
  services.xserver.enable = true;
  services.xserver.autorun = false;
  services.xserver.layout = "us";
  services.xserver.desktopManager.default = "none";
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.i3.enable = true;
  
  environment.systemPackages = with pkgs; [
    arandr
    xrandr # manage monitor
    lxappearance
  ];

}
