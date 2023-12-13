{
  config,
  lib,
  inputs,
  go-todo-exporter,
  ...
}: {
  systemd.user.services = {
    go-todo-exporter = {
      Unit = {
        Description = "Prometheus exporter for TODOs";
      };

      Service = {
        ExecStart = "${go-todo-exporter.default}/bin/go-todo-exporter";
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
