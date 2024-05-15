{
  config,
  pkgs,
  inputs,
  ...
}: {
  services.rpcbind.enable = true; # needed for NFS
  systemd.mounts = [
    {
      type = "nfs";
      mountConfig = {
        Options = "noatime";
      };
      what = "truenas.cosmos.cboxlab.com:/mnt/ssd/media/tv";
      where = "/nfs/tv";
    }
  ];

  systemd.automounts = [
    {
      wantedBy = ["multi-user.target"];
      automountConfig = {
        TimeoutIdleSec = "600";
      };
      where = "/nfs/tv";
    }
  ];
}
