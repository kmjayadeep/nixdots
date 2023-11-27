{ config, pkgs, inputs, ... }:

{
  # necessary system packages
  environment.systemPackages = with pkgs; [
    # system
    psmisc
    htop
    xdg-desktop-portal-gtk
    greetd.tuigreet

    # Essentials
    git
    neovim
    wget
    kitty

    # Desktop
    rofi-wayland
    waybar
    dunst
    foot
    arandr

    # browser
    brave
  ];

  # Remove unecessary preinstalled packages
  environment.defaultPackages = [ ];
  services.xserver.desktopManager.xterm.enable = false;

  # shell
  programs.zsh.enable = true;

  # editor
  programs.neovim.defaultEditor = true;
}
