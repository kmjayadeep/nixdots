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
        efiSysMountPoint = "/efi";
      };

      timeout = 5;
    };
  };
}
