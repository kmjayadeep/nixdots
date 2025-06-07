{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.adb.enable = true;
  users.users.jayadeep.extraGroups = ["adbusers"];
}
