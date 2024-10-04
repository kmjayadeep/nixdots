{
  config,
  lib,
  inputs,
  pkgs,
  go-todo-exporter,
  ...
}: {
  systemd.user.services = {
    go-todo-exporter = {
      Unit = {
        Description = "Prometheus exporter for TODOs";
      };

      Service = {
        Environment="PATH=${pkgs.taskwarrior3}/bin/";
        ExecStart = "${go-todo-exporter.default}/bin/go-todo-exporter";
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
