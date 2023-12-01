{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    yad # used for showing confirm dialog
  ];

  home.file.".config/wlogout/actions" = {
    source = ./wlogout/actions;
    executable = true;
  };

  home.file.".config/wlogout/icons" = {
    source = ./wlogout/icons;
    recursive = true;
  };

  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "suspend";
        text = "Suspend";
        action = "~/.config/wlogout/actions --suspend";
        keybind = "u";
      }
      {
        label = "logout";
        text = "Logout";
        action = "~/.config/wlogout/actions --logout";
        keybind = "e";
      }
      {
        label = "lock";
        text = "Lock";
        action = "~/.config/wlogout/actions --lock";
        keybind = "l";
      }
      {
        label = "reboot";
        text = "Reboot";
        action = "~/.config/wlogout/actions --reboot";
        keybind = "r";
      }
      {
        label = "shutdown";
        text = "Shutdown";
        action = "~/.config/wlogout/actions --shutdown";
        keybind = "s";
      }
    ];
    style = ''
      ${builtins.readFile ./wlogout/style.css}
    '';
  };
}
