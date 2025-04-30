{
  config,
  pkgs,
  inputs,
  ...
}: {
  # https://nixos.wiki/wiki/NFS
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
    {
      type = "nfs";
      mountConfig = {
        Options = "noatime";
      };
      what = "truenas.cosmos.cboxlab.com:/mnt/main/downloads";
      where = "/nfs/downloads";
    }
    {
      type = "nfs";
      mountConfig = {
        Options = "noatime"; # With caching enabled
      };
      what = "truenas.cosmos.cboxlab.com:/mnt/main/k8s/psuite";
      where = "/nfs/psuite";
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
    {
      wantedBy = ["multi-user.target"];
      automountConfig = {
        TimeoutIdleSec = "600";
      };
      where = "/nfs/downloads";
    }
    {
      wantedBy = ["multi-user.target"];
      automountConfig = {
        TimeoutIdleSec = "600";
      };
      where = "/nfs/psuite";
    }
  ];
}
