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
      ];
      ExecStart = "${pkgs.backrest}/bin/backrest";
    };

    Install = {
      WantedBy = ["multi-user.target"];
    };
  };
}
