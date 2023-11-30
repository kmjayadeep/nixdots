{
  config,
  lib,
  pkgs,
  ...
}: {
  # For making hyprland work in VM
  environment.sessionVariables = {
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    HYPRLAND_LOG_WLR = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # bootloader.
  boot = {
    tmp.cleanOnBoot = true;

    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
      };

      timeout = 5;
    };
  };
}
