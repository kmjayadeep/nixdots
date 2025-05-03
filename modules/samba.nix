{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    pkgs.cifs-utils
    pkgs.samba
  ];
  fileSystems."/samba/studio" = {
    device = "//truenas.cosmos.cboxlab.com/studio";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/home/jayadeep/private/truenas/smb-secrets,uid=1000,gid=100"];
  };
}
