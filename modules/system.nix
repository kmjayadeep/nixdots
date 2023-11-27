{ config, pkgs, inputs, ... }:

{
  # Set up locales (timezone and keyboard layout)
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set up user and enable sudo
  # TODO: add initial password
  users.users.jayadeep = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  services.openssh = { enable = true; };

  # Sound
  sound = { enable = true; };
  hardware.pulseaudio.enable = true;

  # Enable bluetooth, enable pulseaudio, enable opengl (for Wayland)
  hardware = {
    bluetooth.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

}
