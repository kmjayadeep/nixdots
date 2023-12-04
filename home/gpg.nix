{
  config,
  lib,
  inputs,
  ...
}: {
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "tty";
    # Increase ttl from 2hr to 24hr;
    defaultCacheTtl = 86400;
    maxCacheTtl = 86400;
  };
}
