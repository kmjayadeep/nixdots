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
          --cmd sway
      '';
    };
  };

  environment.etc."greetd/environments".text = ''
    sway
  '';

  environment.sessionVariables = {
    # make discord, brave etc. work in wayland
    NIXOS_OZONE_WL = "1";
  };

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # For screensharing, file opener etc.
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # Required for a lot of apps
  security.polkit.enable = true;
}
