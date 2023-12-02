{
  pkgs,
  lib,
  inputs,
  ...
}: {
  # hyprland is already installed at system level, this module configures it
  home.packages = with pkgs; [
    # for wallpaper
    swaybg
    rofi-wayland
    waybar
    pamixer
  ];

  home.file.".config/hypr/wallpaper.png".source = ./wallpaper.png;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,auto";

      env = "XCURSOR_SIZE,24";

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;
      };

      input = {
        kb_layout = "us";
        kb_options = "caps:escape";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = false;
        };
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        # Keyword rate
        repeat_rate = 100;
        repeat_delay = 200;
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 10;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = "0.1696";
        };

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      windowrule = [
        "float,wlogout"
        "center,wlogout"
        "animation slide,wlogout"
      ];

      # No windows can request maximize
      windowrulev2 = [
        "nomaximizerequest, class:.*"
      ];
    };
    extraConfig = ''
      exec-once=${pkgs.swaybg}/bin/swaybg -i ~/.config/hypr/wallpaper.png
      exec-once=${pkgs.wlsunset}/bin/wlsunset -l -23 -L -46

      ${builtins.readFile ./hyprland.conf}

      # Audio
      bind =,xf86audiolowervolume,exec,${pkgs.pamixer}/bin/pamixer -d 5
      bind =,xf86audioraisevolume,exec,${pkgs.pamixer}/bin/pamixer -i 5
      bind =,xf86audiomute,exec,${pkgs.pamixer}/bin/pamixer -t
    '';
  };

  # enable automounting disks
  services.udiskie.enable = true;
  services.udiskie.tray = "never"; # tray doesn't work in wayland yet
}
