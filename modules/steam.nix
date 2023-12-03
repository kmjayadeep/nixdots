{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.steam.enable = true;
  # For running games better
  programs.gamemode.enable = true;
}
