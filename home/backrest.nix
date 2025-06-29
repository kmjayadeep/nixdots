{
  pkgs,
  inputs,
  config,
  scripts,
  ...
}: {

  systemd.user.services.backrest = {
    Unit = {
      Description = "Restic GUI";
    };

    Service = {
      Environment = [
        "BACKREST_PORT=127.0.0.1:9898"
        "BACKREST_RESTIC_COMMAND=${pkgs.restic}/bin/restic"
        "BACKREST_CONFIG=${config.home.homeDirectory}/private/backrest/config"
        "BACKREST_DATA=${config.home.homeDirectory}/private/backrest/data"
        "PATH=${pkgs.lib.makeBinPath [ pkgs.bash pkgs.curl pkgs.coreutils pkgs.restic ]}"
      ];
      ExecStart = "${pkgs.backrest}/bin/backrest";
      Restart = "on-failure";
      RestartSec = "5";
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
