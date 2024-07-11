{
  pkgs,
  inputs,
  config,
  syncall,
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

    tw-gtasks-sync = {
      Unit = {
        Description = "Sync taskwarrior to google tasks";
      };

      Timer = {
        # Every hour
        OnCalendar = "*-*-* *:00:00";
        # Start immedietly if it missed the last schedule when the system is off
        Persistent = true;
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

    tw-gtasks-sync = {
      Unit = {
        Wants = ["network-online.target"];
        After = ["network-online.target"];
        Description = "Sync taskwarrior to google tasks";
      };

      Service = {
        Environment = "PATH=/etc/profiles/per-user/jayadeep/bin:/run/current-system/sw/bin";
        ExecStart = "${syncall.syncall}/bin/tw_gtasks_sync -t remindme -l 'TW Reminders'";
        Type = "oneshot";
      };
    };
  };
}
