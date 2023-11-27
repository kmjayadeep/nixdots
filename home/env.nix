{
  config,
  lib,
  inputs,
  ...
}: {
  home.sessionVariables = {
    NIXOS_CONFIG_DIR = "$HOME/workspace/nixdots";
  };
}
