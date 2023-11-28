{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Set up locales (timezone and keyboard layout)
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set default shell for all users
  # also important to set global env vars correctly
  users.defaultUserShell = pkgs.zsh

  # Set up user and enable sudo
  users.users.jayadeep = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
    initialPassword = "password"; # Don't forget to change this
  };

  # Sound
  sound = {enable = true;};
  hardware.pulseaudio.enable = true;

  # Enable bluetooth, enable pulseaudio, enable opengl (for Wayland)
  hardware = {
    bluetooth.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  # Set neovim as default editor
  programs.neovim.defaultEditor = true;
}
