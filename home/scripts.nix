{
  config,
  lib,
  inputs,
  scripts,
  ...
}: {
  # Scripts to install
  home.packages = with scripts; [
    gameoff
    gitignore
    mm
    notes
    pull
    push
    resticman
    vic
  ];
}
