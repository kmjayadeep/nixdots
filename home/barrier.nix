
{
  config,
  lib,
  inputs,
  ...
}: {
  services.barrier.client = {
    enable = true;
    server = "192.168.1.160:24800";
  };
}
