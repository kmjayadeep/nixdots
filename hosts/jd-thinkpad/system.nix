{
  config,
  lib,
  pkgs,
  ...
}: {
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
