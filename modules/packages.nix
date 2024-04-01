{
  config,
  pkgs,
  inputs,
  ...
}: {
  # necessary system packages
  environment.systemPackages = with pkgs; [
    # system
    psmisc
    htop
    xdg-desktop-portal-gtk
    greetd.tuigreet
    mesa # 3d graphics

    # Essentials
    git
    neovim
    wget
    kitty
    pavucontrol # Sound control
    wireguard-tools # Wg-quick
    nfs-utils
    gnumake
    xdg-utils # for xdg-open
    razergenie # manage razor mouse

    # browser
    brave
    google-chrome

    lynx
  ];

  # Remove unecessary preinstalled packages
  environment.defaultPackages = [];
  services.xserver.desktopManager.xterm.enable = false;

  # shell
  programs.zsh.enable = true;
}
