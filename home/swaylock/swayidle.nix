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
        timeout = 20;
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
      {
        timeout = 90;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
