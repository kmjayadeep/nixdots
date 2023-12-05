{
  pkgs,
  inputs,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "Flat-Remix-GTK-Blue-Dark";
      package = pkgs.flat-remix-gtk;
    };

    cursorTheme = {
      name = "Catppuccin-Frappe-Dark-Cursors";
      package = pkgs.catppuccin-cursors.frappeDark;
    };

    iconTheme = {
      name = "Flat-Remix-Blue-Dark";
      package = pkgs.flat-remix-icon-theme;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
