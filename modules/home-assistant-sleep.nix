{
  config,
  lib,
  pkgs,
  ...
}: {
  # Home Assistant webhook services for PC power state management
  systemd.services.home-assistant-sleep = {
    description = "Notify Home Assistant before suspend or shutdown";
    wantedBy = [ "sleep.target" ];
    before = [
      "sleep.target"
      "network.target"
      "network-online.target"
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.curl}/bin/curl -X POST https://home-assistant.cosmos.cboxlab.com/api/webhook/pc-sleep";
      SuccessExitStatus = [ 6 7 ];
    };
  };

  systemd.services.home-assistant-wake = {
    description = "Notify Home Assistant after boot or resume";
    wantedBy = [
      "multi-user.target"
      "post-resume.target"
    ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    unitConfig = {
      StopWhenUnneeded = true;
    };
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.curl}/bin/curl -X POST https://home-assistant.cosmos.cboxlab.com/api/webhook/pc-wake
      '';
      SuccessExitStatus = [ 6 7 ];
    };
  };

}
