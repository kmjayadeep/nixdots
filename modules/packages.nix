{
  config,
  pkgs,
  inputs,
  ...
}: {
  # System packages organized by category
  environment.systemPackages = with pkgs; [
    # === SYSTEM UTILITIES ===
    psmisc                    # Process management tools
    htop                      # System monitor
    exfat                     # SD card filesystem support
    pciutils                  # PCI utilities (lspci)
    iperf                     # Network performance testing

    # === DEVELOPMENT TOOLS ===
    git                       # Version control
    neovim                    # Text editor
    gnumake                   # Build system
    vscode.fhs                # VS Code with FHS environment

    # === DESKTOP & GUI ===
    kitty                     # Terminal emulator
    xdg-desktop-portal-gtk    # Desktop portal for GTK apps
    tuigreet                  # Login manager
    xdg-utils                 # Desktop utilities (xdg-open)
    mesa                      # 3D graphics library
    pavucontrol               # Audio control GUI

    # === NETWORK & CONNECTIVITY ===
    wget                      # File downloader
    wireguard-tools           # VPN tools (wg-quick)
    nfs-utils                 # Network filesystem utilities

    # === BROWSERS ===
    brave                     # Privacy-focused browser
    google-chrome             # Google Chrome browser
    lynx                      # Text-based browser

    # === MEDIA & PHOTOGRAPHY ===
    gphoto2                   # Camera control library
    gphoto2fs                 # Camera filesystem
    kdePackages.isoimagewriter            # ISO image writer

    # === GAMING & WINDOWS COMPATIBILITY ===
    wineWowPackages.stable    # Windows compatibility layer
    winetricks                # Wine configuration tool

    # === HARDWARE SPECIFIC ===
    razergenie                # Razer mouse management

    # === ARCHIVES & COMPRESSION ===
    rar                       # RAR archive support
  ];

  # Remove unecessary preinstalled packages
  environment.defaultPackages = [];
  services.xserver.desktopManager.xterm.enable = false;

  # to allow accessing smb:// protocol in pcmanfm
  services.gvfs.enable = true;

  # shell
  programs.zsh.enable = true;
}
