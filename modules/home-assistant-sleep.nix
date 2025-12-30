{
  config,
  lib,
  pkgs,
  ...
}: {
  # Home Assistant webhook integration - standalone scripts
  
  # Create executable scripts for manual control
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "lights-on" ''
      ${pkgs.curl}/bin/curl -X POST https://home-assistant.cosmos.cboxlab.com/api/webhook/pc-wake
      echo "Lights turned ON"
    '')
    
    (pkgs.writeShellScriptBin "lights-off" ''
      ${pkgs.curl}/bin/curl -X POST https://home-assistant.cosmos.cboxlab.com/api/webhook/pc-sleep
      echo "Lights turned OFF"
    '')
  ];
}
