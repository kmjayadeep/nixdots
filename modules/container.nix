{
  config,
  pkgs,
  inputs,
  ...
}: {
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = false;
    defaultNetwork.settings.dns_enabled = true;
    autoPrune.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    autoPrune.enable = true;
    daemon.settings = {
      ipv6 = true;
      fixed-cidr-v6 = "fd82:852b:c100:100::/64";
    };
  };
}
