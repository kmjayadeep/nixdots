{
  pkgs,
  inputs,
  config,
  ...
}: {
  systemd.user.timers = {
    backup-nuc = {
      Unit = {
        Description = "Backup the workspace everyday";
      };

      Timer = {
        # Every day 5am
        OnCalendar = "*-*-* 05:00:00";
        # Start immedietly if it missed the last schedule when the system is off
        Persistent = true;
      };

      Install = {
        WantedBy = ["timers.target"];
      };
    };
    backup-private = {
      Unit = {
        Description = "Backup private folder every hour";
      };

      Timer = {
        # Every hour
        OnCalendar = "*-*-* *:00:00";
      };

      Install = {
        WantedBy = ["timers.target"];
      };
    };
  };

  systemd.user.services = {
    backup-nuc = {
      Unit = {
        Description = "Backup the workspace";
        Wants = ["network-online.target"];
        After = ["network-online.target"];
      };

      Service = {
        Environment = "PATH=/etc/profiles/per-user/jayadeep/bin:/run/current-system/sw/bin";
        ExecStart = "${config.home.homeDirectory}/workspace/scripts/backup";
        Type = "oneshot";
      };
    };

    backup-private = {
      Unit = {
        Description = "Backup private folder";
        Wants = ["network-online.target"];
        After = ["network-online.target"];
      };

      Service = {
        Environment = "PATH=/etc/profiles/per-user/jayadeep/bin:/run/current-system/sw/bin";
        ExecStart = "${config.home.homeDirectory}/workspace/scripts/backup_private";
        Type = "oneshot";
      };
    };
  };
}
