{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    NIXOS_CONFIG_DIR = "${config.home.homeDirectory}/workspace/nixdots";
    VAULT_ADDR = "https://vault.cosmos.cboxlab.com";
    KUBECONFIG = "${config.home.homeDirectory}/private/kube/config";
    KUBECACHEDIR = "$XDG_CACHE_HOME/kube";
    BROWSER = "${pkgs.brave}/bin/brave";
  };
}
