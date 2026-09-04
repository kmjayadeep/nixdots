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

  boot = {
    tmp.cleanOnBoot = true;

    # Reboot after a captured kernel panic instead of remaining wedged.
    kernelParams = ["panic=30"];
    kernel.sysctl = {
      "kernel.hardlockup_panic" = 1;
      "kernel.panic_on_oops" = 1;
      "kernel.softlockup_panic" = 1;
    };

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };

      efi = {
        canTouchEfiVariables = true;
      };

      timeout = 5;
    };
  };

  # Reset a completely unresponsive system and retain useful health tooling.
  systemd.settings.Manager.RuntimeWatchdogSec = "1min";

  services.smartd.enable = true;

  environment.systemPackages = with pkgs; [
    nvme-cli
    smartmontools
  ];
}
