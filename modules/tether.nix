{
  config,
  pkgs,
  inputs,
  ...
}: {
  services.haveged.enable = true;

  # https://raw.githubusercontent.com/lakinduakash/linux-wifi-hotspot/master/src/scripts/create_ap.conf
  services.create_ap = {
    enable = true;
    settings = {
      INTERNET_IFACE = "eno1";
      WIFI_IFACE = "wlp0s20f3";
      SSID = "Nuc wifi";
      PASSPHRASE = "parayilla";
      IEEE80211N = 1;
      SHARE_METHOD = "bridge";
    };
  };

}
