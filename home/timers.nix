{
  pkgs,
  inputs,
  ...
}: {
  systemd.user.timers = {
    backup-nuc = {
      Unit = {
        Description = "Backup the workspace";
      };

      Timer = {
        # Every day 9am
        OnCalendar="*-*-* 9:00:00";
        # Start immedietly if it missed the last schedule when the system is off
        Persistent=true;
      };
    };
    backup-private = {
      Unit = {
        Description = "Backup private folder";
      };

      Timer = {
        # Every hour
        OnCalendar="*-*-* *:00:00";
      };
    };
  };
}
