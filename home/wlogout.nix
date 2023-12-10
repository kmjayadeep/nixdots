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
        text = "Suspend [s]";
        action = "~/.config/wlogout/actions --suspend";
        keybind = "s";
      }
      {
        label = "logout";
        text = "Logout [x]";
        action = "~/.config/wlogout/actions --logout";
        keybind = "x";
      }
      {
        label = "lock";
        text = "Lock [l]";
        action = "~/.config/wlogout/actions --lock";
        keybind = "l";
      }
      {
        label = "reboot";
        text = "Reboot [r]";
        action = "~/.config/wlogout/actions --reboot";
        keybind = "r";
      }
      {
        label = "hibernate";
        text = "Hibernate [h]";
        action = "~/.config/wlogout/actions --hibernate";
        keybind = "h";
      }
      {
        label = "shutdown";
        text = "Shutdown [S]";
        action = "~/.config/wlogout/actions --shutdown";
        keybind = "S";
      }
    ];
    #TODO: Not working
    style = ''
      ${builtins.readFile ./wlogout/style.css}
    '';
  };
}
