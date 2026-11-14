{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.haLightHooks;
  webhook = "https://home-assistant.cosmos.cboxlab.com/api/webhook";
  curl = "${pkgs.curl}/bin/curl";

  # Sleep/shutdown: the network is still up, so one quick try. Never block suspend on it.
  lightOff = pkgs.writeShellScript "ha-light-off" ''
    ${curl} -fsS --max-time 5 -X POST ${webhook}/pc-sleep || true
  '';
  # Boot/resume: Wi-Fi/DHCP may still be coming up, so keep retrying for about a minute.
  # {"auto": true} tells HA to turn the light on only when it is dark (the manual lights-on always turns it on).
  lightOnIfDark = pkgs.writeShellScript "ha-light-on-if-dark" ''
    ${curl} -fsS --max-time 5 --retry 12 --retry-delay 5 --retry-all-errors \
      -X POST -H 'Content-Type: application/json' -d '{"auto": true}' ${webhook}/pc-wake
  '';
in {
  options.services.haLightHooks.enable =
    lib.mkEnableOption "living room light follows this PC's sleep, wake, boot and shutdown via Home Assistant webhooks";

  config = lib.mkMerge [
    {
      # Manual control, on every host.
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "lights-on" ''
          ${curl} -fsS -X POST ${webhook}/pc-wake && echo "Lights turned ON"
        '')
        (pkgs.writeShellScriptBin "lights-off" ''
          ${curl} -fsS -X POST ${webhook}/pc-sleep && echo "Lights turned OFF"
        '')
      ];
    }

    (lib.mkIf cfg.enable {
      # Boot → on if dark; shutdown/reboot → off (ExecStop runs while the network is still up).
      systemd.services.ha-light-session = {
        description = "Living room light follows PC power (boot and shutdown)";
        wantedBy = ["multi-user.target"];
        wants = ["network-online.target"];
        after = ["network-online.target"];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = lightOnIfDark;
          ExecStop = lightOff;
        };
      };

      # Suspend → off.
      systemd.services.ha-light-sleep = {
        description = "Turn the living room light off before suspend";
        wantedBy = ["sleep.target"];
        before = ["sleep.target"];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = lightOff;
        };
      };

      # Resume → on if dark.
      systemd.services.ha-light-resume = {
        description = "Turn the living room light on after resume if it is dark";
        wantedBy = ["post-resume.target"];
        after = ["post-resume.target"];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = lightOnIfDark;
        };
      };
    })
  ];
}
