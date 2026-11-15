{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.haLightHooks;
  webhook = "https://home-assistant.cosmos.cboxlab.com/api/webhook";
  curl = "${pkgs.curl}/bin/curl";

  # The hooks run while the network is coming up or going down. dnsmasq kept failing for ~20 s after
  # resume even with IPv4 back, so skip DNS: pin the name to Home Assistant's LAN address (TLS still checks
  # the name).
  hookCurl = "${curl} -fsS --max-time 5 --resolve home-assistant.cosmos.cboxlab.com:443:192.168.1.90";

  # Sleep/shutdown: one quick try. Never block suspend or shutdown on it.
  lightOff = pkgs.writeShellScript "ha-light-off" ''
    ${hookCurl} -X POST ${webhook}/pc-sleep || true
  '';
  # Boot/resume: the link may still be coming up, so retry for about two minutes.
  # {"auto": true} tells HA to turn the light on only when it is dark (the manual lights-on always turns it on).
  lightOnIfDark = pkgs.writeShellScript "ha-light-on-if-dark" ''
    for _ in $(seq 24); do
      ${hookCurl} -X POST -H 'Content-Type: application/json' -d '{"auto": true}' ${webhook}/pc-wake && exit 0
      sleep 5
    done
    exit 1
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

      # Suspend → off. NetworkManager drops the link the moment logind announces sleep (its pre-down
      # dispatcher scripts are not waited for), so no sleep hook can reach Home Assistant reliably. The
      # suspend paths (wlogout's i3exit, the polybar menu) call this before `systemctl suspend` instead.
      environment.systemPackages = [(pkgs.writeShellScriptBin "ha-light-sleep" "exec ${lightOff}")];

      # Resume → on if dark. suspend.target (and friends) is reached again when the system wakes up;
      # post-resume.target does not exist here. The script retries until NetworkManager has the link back.
      systemd.services.ha-light-resume = let
        targets = ["suspend.target" "hibernate.target" "hybrid-sleep.target" "suspend-then-hibernate.target"];
      in {
        description = "Turn the living room light on after resume if it is dark";
        wantedBy = targets;
        after = targets;
        serviceConfig = {
          Type = "oneshot";
          ExecStart = lightOnIfDark;
        };
      };
    })
  ];
}
