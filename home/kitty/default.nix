{
  config,
  lib,
  inputs,
  ...
}: {

  home.file.".config/kitty/theme-gruvbox.conf".source = ./theme-gruvbox.conf;

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono";
      size = 16;
    };
    shellIntegration.enableZshIntegration = true;
    extraConfig = ''
      include theme-gruvbox.conf
    '';
  };
}
