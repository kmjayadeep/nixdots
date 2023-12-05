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
  networking = {
    networkmanager.enable = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
    # If using NetworkManager:
    networkmanager.dns = "none";
  };
  programs.nm-applet.enable = true;

  # Set default shell for all users
  # also important to set global env vars correctly
  users.defaultUserShell = pkgs.zsh;

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
    bluetooth = {
      enable = true;
      settings = {
        General = {
          # Show battery percentage of bt headset
          Experimental = true;
        };
      };
    };
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  # Set neovim as default editor
  programs.neovim.defaultEditor = true;

  # auto mount usb devices
  services.udisks2.enable = true;

  # For swaylock to work
  security.pam.services.swaylock = {};

  # for ssh and gpg auto unlock at login
  # Not using ssh agent at the moment
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  # Prometheus Node-exporter for exposing node metrics to prometheus
  services.prometheus.exporters.node.enable = true;

  # install tailscale vpn; run tailscale up to setup initially
  services.tailscale.enable = true;
}
