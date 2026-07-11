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
  services.xserver.windowManager.i3.enable = true;

  services.displayManager.defaultSession = "none+i3";

  environment.systemPackages = with pkgs; [
    xrandr # manage monitor
    lxrandr # GUI for monitor layout; arandr is currently broken on unstable/python 3.14
    lxappearance
  ];

  programs.dconf.enable = true;

  # Required by apps such as Flameshot that talk to the
  # org.freedesktop.portal.Desktop D-Bus service.
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = ["gtk"];
  };
}
