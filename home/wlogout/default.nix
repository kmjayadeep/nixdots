{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    i3lock-fancy
  ];

  home.file.".config/wlogout/i3exit" = {
    source = ./i3exit;
    executable = true;
  };

  home.file.".config/wlogout/icons" = {
    source = ./icons;
    recursive = true;
  };

  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "suspend";
        text = "Suspend [s]";
        action = "~/.config/wlogout/i3exit suspend";
        keybind = "s";
      }
      {
        label = "logout";
        text = "Logout [x]";
        action = "~/.config/wlogout/i3exit logout";
        keybind = "x";
      }
      {
        label = "lock";
        text = "Lock [l]";
        action = "~/.config/wlogout/i3exit lock";
        keybind = "l";
      }
      {
        label = "reboot";
        text = "Reboot [r]";
        action = "~/.config/wlogout/i3exit reboot";
        keybind = "r";
      }
      {
        label = "hibernate";
        text = "Hibernate [h]";
        action = "~/.config/wlogout/i3exit hibernate";
        keybind = "h";
      }
      {
        label = "shutdown";
        text = "Shutdown [S]";
        action = "~/.config/wlogout/i3exit shutdown";
        keybind = "S";
      }
    ];
    style = ''
      ${builtins.readFile ./style.css}
    '';
  };
}
