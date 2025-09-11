{
  config,
  pkgs,
  inputs,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      roboto
      openmoji-color
      nerd-fonts.jetbrains-mono
    ];

    fontconfig = {
      # Font rendering optimizations
      hinting = {
        enable = true;
        autohint = true;
        style = "slight";              # Better rendering than full hinting
      };

      subpixel = {
        rgba = "rgb";                  # Subpixel rendering for LCD screens
      };

      # Set default fonts for better consistency
      defaultFonts = {
        monospace = ["JetBrains Mono" "Nerd Font Complete"];
        sansSerif = ["Roboto" "DejaVu Sans"];
        serif = ["DejaVu Serif"];
        emoji = ["OpenMoji Color"];
      };

      # Additional optimizations
      antialias = true;
      cache32Bit = true;               # Enable 32-bit font cache
    };
  };
}
