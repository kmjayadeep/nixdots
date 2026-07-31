{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.firewall = {
    allowedTCPPorts = [
      8080 # Calibre content server
      9090 # Calibre wireless device connection
    ];
    allowedUDPPorts = [
      54982 # Calibre wireless device discovery
    ];
  };

  # bootloader.
  boot = {
    tmp.cleanOnBoot = true;

    loader = {
      systemd-boot.enable = true;

      efi = {
        canTouchEfiVariables = true;
      };

      timeout = 5;
    };
  };
}
