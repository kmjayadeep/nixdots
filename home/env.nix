{ config, lib, inputs, ... }:

{
  home.sessionVariables = {
    NIXOS_CONFIG_DIR = "~/workspace/nixdots"
  };
}
