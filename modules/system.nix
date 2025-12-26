{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Set up locales (timezone and keyboard layout)
  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable networking
  networking = {
    networkmanager.enable = true;
    nameservers = [
      "127.0.0.53" # DNSCrypt proxy
      "192.168.1.250" # AdGuard as fallback
      "1.1.1.1" # Use cloudlfare when everything else fails
    ];
    networkmanager.dns = "none";

    # Configure resolvconf to include all nameservers, not just local ones
    resolvconf.extraConfig = ''
      resolv_conf_local_only=NO
    '';
  };
  programs.nm-applet.enable = true;

  # Encrypted DNS
  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      listen_addresses = ["127.0.0.53:53"];

      # Server selection preferences
      ipv6_servers = true;
      require_dnssec = true;
      require_nolog = false;
      require_nofilter = false;  # Allow filtering since using AdGuard

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
    };
  };

  systemd.services.dnscrypt-proxy.serviceConfig.StateDirectory = "dnscrypt-proxy";

  # Set default shell for all users
  # also important to set global env vars correctly
  users.defaultUserShell = pkgs.zsh;

  # Set up user and enable sudo
  users.users.jayadeep = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "podman"
      "video" # For screen brightness control
      "render" # For video editing
    ];
    shell = pkgs.zsh;
    initialPassword = "password"; # Don't forget to change this
  };

  # Disable alsa and pulseaudio
  services.pulseaudio.enable = false;

  # brightness control
  programs.light.enable = true;

  # Sound with pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  security.rtkit.enable = true;

  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  # Enhanced hardware configuration
  hardware = {
    bluetooth = {
      enable = true;
      settings = {
        General = {
          # Show battery percentage of bt headset
          Experimental = true;
        };
      };
    };
    graphics = {
      enable = true;
    };
  };

  # Set neovim as default editor
  programs.neovim.defaultEditor = true;

  # auto mount usb devices
  services.udisks2.enable = true;

  # For swaylock to work
  security.pam.services.swaylock = {};

  # for ssh and gpg auto unlock at login
  # Not using ssh agent at the moment
  # services.gnome.gnome-keyring.enable = true; # Disabled since using i3, not GNOME
  programs.seahorse.enable = true;

  # Prometheus Node-exporter for exposing node metrics to prometheus
  services.prometheus.exporters.node.enable = true;

  # install tailscale vpn; run the following to setup initially
  # sudo tailscale up --accept-routes --accept-dns=false
  services.tailscale = {
    enable = true;
    extraSetFlags = [
      "--accept-dns=false"
    ];
  };

  # fail2ban for SSH protection. Comes with ssh jail by default
  services.fail2ban = {
    enable = true;
    maxretry = 5;
    bantime = "1h";
  };

  users.extraGroups.vboxusers.members = [ "jayadeep" ];
}
