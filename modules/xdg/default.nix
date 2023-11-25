{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.xdg;

in {
  options.modules.xdg = { enable = mkEnableOption "xdg"; };
  config = mkIf cfg.enable {
    xdg.userDirs = {
      enable = true;
      documents = "$HOME/documents/";
      download = "$HOME/downloads/";
      videos = "$HOME/media/videos/";
      music = "$HOME/media/music/";
      pictures = "$HOME/media/pictures";
      desktop = "$HOME/desktop/";
      publicShare = "$HOME/share/";
      templates = "$HOME/templates/";
    };
  };
}
