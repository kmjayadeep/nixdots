{ config, pkgs, inputs, ... }:

{
  # bootloader.
    boot = {
	tmp.cleanOnBoot = true;
        loader = {
		grub.enable = true;
		grub.device = "/dev/sda";
		grub.useOSProber = true;
		grub.enableCryptodisk = true;
		timeout = 5;
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
    	git
	neovim
	wget
	kitty
    ];

    programs.zsh.enable = true;
    programs.neovim.defaultEditor = true;

    # TODO: some sane default nvim config for root


    # Set up locales (timezone and keyboard layout)
    time.timeZone = "Europe/Berlin";
    i18n.defaultLocale = "en_US.UTF-8";

    # Set up user and enable sudo
    users.users.jayadeep = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.zsh;
    };

    services.openssh = {
	enable = true;
    };

    # Sound
    sound = {
        enable = true;
    };

    hardware.pulseaudio.enable = true;

    # Do not touch
    system.stateVersion = "23.05";
}
