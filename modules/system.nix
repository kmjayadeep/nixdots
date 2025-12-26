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
      # DNSMasq will add localhost here. The options below will be used as fallback
      "192.168.1.250" # AdGuard home
      "1.1.1.1"
    ];
    networkmanager.dns = "none";

    # Configure resolvconf to include all nameservers, not just local ones
    resolvconf.extraConfig = ''
      resolv_conf_local_only=NO
    '';
  };
  programs.nm-applet.enable = true;

  # DNS caching with dnsmasq
  services.dnsmasq = {
    enable = true;
    settings = {
      # Listen on localhost only
      listen-address = "127.0.0.1";

      # Don't read /etc/resolv.conf for upstream servers
      no-resolv = true;

      # Bind to interfaces to prevent port conflicts
      bind-interfaces = true;

      # Upstream DNS servers (AdGuard primary, Cloudflare secondary)
      server = [
        "192.168.1.250"  # AdGuard
        "1.1.1.1"        # Cloudflare fallback
      ];

      # Cache settings
      cache-size = 1000;

      # Don't forward plain names
      domain-needed = true;

      # Don't forward addresses in non-routed address spaces
      bogus-priv = true;
    };
  };

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
