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
    # pi is a Bun-compiled binary, so pi-browser-use cannot use process.execPath to run chrome-devtools-mcp
    PI_BROWSER_USE_NODE = "${pkgs.nodejs_22}/bin/node";
  };
}
