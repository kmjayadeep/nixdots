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
    {
      type = "nfs";
      mountConfig = {
        Options = "noatime";
      };
      what = "truenas.cosmos.cboxlab.com:/mnt/ssd/drive";
      where = "/nfs/drive";
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
    {
      wantedBy = ["multi-user.target"];
      automountConfig = {
        TimeoutIdleSec = "600";
      };
      where = "/nfs/drive";
    }
  ];
}
