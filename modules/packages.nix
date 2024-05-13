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
    exfat # sd card
    gphoto2
    gphoto2fs

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

    # others
    iperf
    pciutils

    # Nas Access
    cifs-utils
    samba
  ];

  # Remove unecessary preinstalled packages
  environment.defaultPackages = [];
  services.xserver.desktopManager.xterm.enable = false;

  # to allow accessing smb:// protocol in pcmanfm
  services.gvfs.enable = true;

  # shell
  programs.zsh.enable = true;
}
