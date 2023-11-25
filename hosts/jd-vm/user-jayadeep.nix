{ config, lib, inputs, ...}:

{
    imports = [ ../../modules/default.nix ];
    config.modules = {
      # system
      xdg.enable = true;
    };
}
