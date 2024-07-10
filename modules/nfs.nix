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
      what = "truenas.cosmos.cboxlab.com:/mnt/main/media/tv";
      where = "/nfs/tv";
    }
    {
      type = "nfs";
      mountConfig = {
        Options = "noatime";
      };
      what = "truenas.cosmos.cboxlab.com:/mnt/main/drive";
      where = "/nfs/drive";
    }
    {
      type = "nfs";
      mountConfig = {
        Options = "noatime";
      };
      what = "truenas.cosmos.cboxlab.com:/mnt/main/documents";
      where = "/nfs/documents";
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
    {
      wantedBy = ["multi-user.target"];
      automountConfig = {
        TimeoutIdleSec = "600";
      };
      where = "/nfs/documents";
    }
  ];
}
