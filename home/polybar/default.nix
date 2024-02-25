{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    polybarFull
  ];

  home.file.".config/polybar/launch.sh" = {
    source = ./launch.sh;
    executable = true;
  };

  home.file.".config/polybar/config.ini" = {
    source = ./config.ini;
  };
}
