{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Login screen
  services.greetd = {
    enable = true;
    settings = {
      default_session.command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --cmd Hyprland
      '';
    };
  };

  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    # make discord, brave etc. work in wayland
    NIXOS_OZONE_WL = "1"
  };

  # For screensharing, file opener etc.
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # Required for a lot of apps
  security.polkit.enable = true;
}
