{
  pkgs,
  lib,
  inputs,
  ...
}: {
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        # Lock when idle for 10m
        timeout = 600;
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
      {
        # Suspend when idle for 1h
        timeout = 3600;
        command = "${pkgs.swaylock-effects}/bin/systemctl suspend";
      }
    ];
  };
}
