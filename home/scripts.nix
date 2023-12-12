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
    pull
    push
  ];

}
