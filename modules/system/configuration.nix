{ config, pkgs, inputs, ... }:

{

  # bootloader.
  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      grub = {
        useOSProber = true;
        enableCryptodisk = true;

        # EUFI installation
        device = "nodev";
        efiSupport = true;
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/efi";
      };

      timeout = 5;
      systemd-boot.enable = true;
    };
  };

  # Nix settings, auto cleanup and enable flakes
  nix = {
    settings.auto-optimise-store = true;
    settings.allowed-users = [ "jayadeep" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Remove unecessary preinstalled packages
  environment.defaultPackages = [ ];
  services.xserver.desktopManager.xterm.enable = false;

  # necessary system packages
  environment.systemPackages = with pkgs; [
    # system
    psmisc
    htop
    xdg-desktop-portal-gtk
    greetd.tuigreet

    # Essentials
    git
    neovim
    wget
    kitty

    # Desktop
    rofi-wayland
    waybar
    dunst
    foot
    arandr
  ];

  programs.zsh.enable = true;
  programs.neovim.defaultEditor = true;

  # TODO: some sane default nvim config for root

  # Set up locales (timezone and keyboard layout)
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  # Set up user and enable sudo
  # TODO: add initial password
  users.users.jayadeep = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  services.openssh = { enable = true; };

  # Sound
  sound = { enable = true; };

  hardware.pulseaudio.enable = true;

  environment.sessionVariables = {
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    HYPRLAND_LOG_WLR = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

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

  # For screensharing, file opener etc.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Disable bluetooth, enable pulseaudio, enable opengl (for Wayland)
  hardware = {
    bluetooth.enable = false;
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  # Do not touch
  system.stateVersion = "23.05";
}
