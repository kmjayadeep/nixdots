{
  pkgs,
  inputs,
  ...
}: {

  home.packages = with pkgs; [
    yad # used for showing confirm dialog
  ];

  home.file.".config/hypr/wlogout/actions" = {
    source = ./wlogout/actions;
    executable = true;
  };

  home.file.".config/hypr/wlogout/icons" = {
    source = ./wlogout/icons;
    recursive = true;
  };

  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "suspend";
        text = "Suspend";
        action = "~/.config/hypr/wlogout/actions --suspend";
        keybind = "u";
      }
      {
        label = "logout";
        text = "Logout";
        action = "~/.config/hypr/wlogout/actions --logout";
        keybind = "e";
      }
      {
        label = "lock";
        text = "Lock";
        action = "~/.config/hypr/wlogout/actions --lock";
        keybind = "l";
      }
      {
        label = "reboot";
        text = "Reboot";
        action = "~/.config/hypr/wlogout/actions --reboot";
        keybind = "r";
      }
      {
        label = "shutdown";
        text = "Shutdown";
        action = "~/.config/hypr/wlogout/actions --shutdown";
        keybind = "s";
      }

    ];
    style = ''
      ${builtins.readFile ./wlogout/style.css}
    '';
  };
}
