{
  config,
  lib,
  inputs,
  scripts,
  ...
}: {
  # Scripts to install
  home.packages = with scripts; [
    gitignore
    mm
    notes
    pomo
    pull
    push
    resticman
    vic
  ];
}
