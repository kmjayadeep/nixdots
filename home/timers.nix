{
  pkgs,
  inputs,
  config,
  scripts,
  ...
}: {
  systemd.user.timers = {
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
    backup-private = {
      Unit = {
        Description = "Backup private folder";
        Wants = ["network-online.target"];
        After = ["network-online.target"];
      };

      Service = {
        ExecStart = "${scripts.backup_private}/bin/backup_private";
        Type = "oneshot";
      };
    };
  };
}
