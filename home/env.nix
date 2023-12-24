{
  config,
  lib,
  inputs,
  ...
}: {
  home.sessionVariables = {
    NIXOS_CONFIG_DIR = "${config.home.homeDirectory}/workspace/nixdots";
    KUBECONFIG = "${config.home.homeDirectory}/private/kube/config";
    KUBECACHEDIR = "$XDG_CACHE_HOME/kube";
  };
}
