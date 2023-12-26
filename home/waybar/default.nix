{
  pkgs,
  inputs,
  config,
  scripts,
  ...
}: let
  # Dependencies
  cat = "${pkgs.coreutils}/bin/cat";
  cut = "${pkgs.coreutils}/bin/cut";
  find = "${pkgs.findutils}/bin/find";
  grep = "${pkgs.gnugrep}/bin/grep";
  pgrep = "${pkgs.procps}/bin/pgrep";
  tail = "${pkgs.coreutils}/bin/tail";
  wc = "${pkgs.coreutils}/bin/wc";
  tailscale = "${pkgs.tailscale}/bin/tailscale";
  xargs = "${pkgs.findutils}/bin/xargs";
  timeout = "${pkgs.coreutils}/bin/timeout";
  ping = "${pkgs.iputils}/bin/ping";

  jq = "${pkgs.jq}/bin/jq";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  journalctl = "${pkgs.systemd}/bin/journalctl";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  playerctld = "${pkgs.playerctl}/bin/playerctld";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  foot = "${pkgs.foot}/bin/foot";
  neomutt = "${pkgs.neomutt}/bin/neomutt";

  # Function to simplify making waybar outputs
  jsonOutput = name: {
    pre ? "",
    text ? "",
    tooltip ? "",
    alt ? "",
    class ? "",
    percentage ? "",
  }: "${pkgs.writeShellScriptBin "waybar-${name}" ''
    set -euo pipefail
    ${pre}
    ${jq} -cn \
      --arg text "${text}" \
      --arg tooltip "${tooltip}" \
      --arg alt "${alt}" \
      --arg class "${class}" \
      --arg percentage "${percentage}" \
      '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
  ''}/bin/waybar-${name}";

  hyprland = config.wayland.windowManager.hyprland.package;
in {
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    style = ''
      ${builtins.readFile ./style.css}
    '';

    settings = {
      botttom = {
        layer = "top";
        height = 32;
        position = "bottom";
        modules-left = [
          "custom/kcontext"
        ];

        modules-center = [
          "custom/todo"
        ];

        modules-right = [
          "custom/publicweather"
          "network#speed"
          "custom/tailscale"
        ];

        "network#speed" = {
          interval = 3;
          tooltip = false;
          format = "  {bandwidthUpBytes}   {bandwidthDownBytes}";
          on-click = "";
        };

        "custom/todo" = {
          exec = "${scripts.todo}/bin/todo count";
          return-type = "text";
          interval = 5;
        };
        "custom/kcontext" = {
          exec = "KUBECONFIG=${config.home.homeDirectory}/private/kube/config ${scripts.kcontext}/bin/kcontext";
          return-type = "text";
          interval = 2;
        };
        "custom/tailscale" = {
          format = "TS ";
          exec = "echo '{\"class\": \"connected\"}'";
          exec-if = "${tailscale} status";
          return-type = "text";
          interval = 5;
        };
        "custom/publicweather" = {
          exec = "${scripts.publicweather}/bin/publicweather";
          return-type = "text";
          interval = 5;
        };
      };

      primary = {
        layer = "top";
        height = 32;
        position = "top";
        modules-left = [
          "hyprland/workspaces"
        ];

        modules-center = [
          "custom/pomo"
          "clock"
          "custom/unread-mail"
        ];

        modules-right = [
          "custom/nowplaying"
          "cpu"
          "memory"
          "pulseaudio"
          "network#info"
          "battery"
          "tray"
        ];

        "memory" = {
          "interval" = 30;
          "format" = "{}% ";
          "max-length" = 10;
        };

        "cpu" = {
          "interval" = 10;
          "format" = "{}% ";
          "max-length" = 10;
        };

        "hyprland/workspaces" = {
          "format" = "{icon}";
          "on-click" = "activate";
          "format-icons" = {
            "1" = "  Web";
            "2" = "  Editor";
            "3" = "  Term";
            "4" = "  Remote";
            "5" = "  Todo";
            "6" = "  Social";
            "7" = "  Steam";
            "8" = "  Game";
            "9" = "  Scripts";
            "10" = "  Media";
          };
          "sort-by-number" = true;
        };

        clock = {
          interval = 1;
          # format = "{:%b %d  %I:%M %p}";
          format = "{:%a, %b %d  %I:%M %p}";
          on-click-left = "mode";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "   0%";
          format-icons = {
            headphone = "󰋋";
            headset = "󰋎";
            portable = "";
            default = ["" "" ""];
          };
          on-click = pavucontrol;
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰒳";
            deactivated = "󰒲";
          };
        };
        "network#info" = {
          interval = 3;
          tooltip = true;
          format-wifi = "  {essid}";
          format-ethernet = "󰈁 Connected";
          format-disconnected = "";
          on-click = "";
        };
        battery = {
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          "format" = "{icon} {capacity}%";
          "format-plugged" = "  {capacity}%";
          "format-charging" = " {capacity}%";
          "format-icons" = ["" "" "" "" ""];
          "format-alt" = "{icon} {time}";
          "format-time" = "{H}h {M}min";
          "tooltip" = true;
        };
        "custom/unread-mail" = {
          interval = 5;
          return-type = "json";
          exec = jsonOutput "unread-mail" {
            pre = ''
              count=$(${find} ~/private/mail/accounts/*/Inbox/new -type f | ${wc} -l)
              if ${pgrep} mbsync &>/dev/null; then
                status="syncing"
              else if [ "$count" == "0" ]; then
                status="read"
              else
                status="unread"
              fi
              fi
            '';
            text = "$count";
            alt = "$status";
          };
          format = "{icon} ({})";
          format-icons = {
            "read" = "󰇯";
            "unread" = "󰇮";
            "syncing" = "󰁪";
          };
          on-click = "${foot} -T neomutt ${neomutt}";
        };
        "custom/currentplayer" = {
          interval = 2;
          return-type = "json";
          exec-if = "${playerctl} --ignore-player=brave status 2>/dev/null";
          exec = jsonOutput "currentplayer" {
            pre = ''
              player="$(${playerctl} --ignore-player=brave status -f "{{playerName}}" 2>/dev/null || echo "No player active" | ${cut} -d '.' -f1)"
              count="$(${playerctl} --ignore-player=brave -l 2>/dev/null | ${wc} -l)"
              if ((count > 1)); then
                more=" +$((count - 1))"
              else
                more=""
              fi
            '';
            alt = "$player";
            tooltip = "$player ($count available)";
            text = "$more";
          };
          format = "{icon}{}";
          format-icons = {
            "No player active" = " ";
            "Celluloid" = "󰎁 ";
            "spotify" = "󰓇 ";
            "ncspot" = "󰓇 ";
            "qutebrowser" = "󰖟 ";
            "firefox" = " ";
            "discord" = " 󰙯 ";
            "sublimemusic" = " ";
            "kdeconnect" = "󰄡 ";
            "chromium" = " ";
          };
          on-click = "${playerctld} shift";
          on-click-right = "${playerctld} unshift";
        };
        "custom/nowplaying" = {
          exec-if = "${playerctl} --ignore-player=brave status 2>/dev/null";
          exec = jsonOutput "nowplaying" {
            pre = ''
              text="$(${playerctl} --ignore-player=brave metadata --format '{{title}} - {{artist}}')"
              alt="$(${playerctl} --ignore-player=brave metadata --format '{{status}}')"
              tooltip="$(${playerctl} --ignore-player=brave metadata --format '{{title}} - {{artist}} ({{album}})')"
            '';
            alt = "$alt";
            tooltip = "$tooltip";
            text = "$text";
          };
          return-type = "json";
          interval = 2;
          max-length = 30;
          format = "{icon} {}";
          format-icons = {
            "Playing" = "󰐊";
            "Paused" = "󰏤 ";
            "Stopped" = "󰓛";
          };
          on-click = "${playerctl} play-pause";
          on-scroll-up = "${playerctl} previous";
          on-scroll-down = "${playerctl} next";
        };
        "custom/pomo" = {
          exec = "${scripts.pomo}/bin/pomo show";
          return-type = "text";
          interval = 2;
        };
      };
    };
  };
}
