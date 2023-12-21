{
  config,
  lib,
  inputs,
  ...
}: {
  home.sessionVariables = {
    NIXOS_CONFIG_DIR = "$HOME/workspace/nixdots";
    KUBECONFIG = "$HOME/private/kube/config";
    KUBECACHEDIR = "$XDG_CACHE_HOME/kube";
  };
}
