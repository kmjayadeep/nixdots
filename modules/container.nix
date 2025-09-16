{
  config,
  pkgs,
  inputs,
  ...
}: {
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
    autoPrune.enable = true;
  };

  # Disable docker if podman is enabled to avoid conflicts
  virtualisation.docker = {
    enable = false;
    enableOnBoot = false;
    autoPrune.enable = true;
    daemon.settings = {
      ipv6 = true;
      fixed-cidr-v6 = "fd82:852b:c100:100::/64";
    };
  };
}
