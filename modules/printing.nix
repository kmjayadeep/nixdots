{
  config,
  pkgs,
  inputs,
  ...
}: {

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  services.printing.enable = true;
  environment.systemPackages = with pkgs; [ hplip ];
  services.printing.drivers = [ pkgs.hplip ];

}
