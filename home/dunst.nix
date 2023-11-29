{
  pkgs,
  inputs,
  ...
}: {

  home.packages = with pkgs; [
    dunst
    libnotify
  ];

  services.dunst = {
    enable = true;
  };

  home.file.".config/dunst/dunstrc".source = ../assets/dunstrc;

}
