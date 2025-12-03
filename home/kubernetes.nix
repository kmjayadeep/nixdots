{
  pkgs,
  inputs,
  ...
}: {
  home.file.".kube/kubie.yaml".source = ../assets/kubie.yaml;

  home.packages = with pkgs; [
    kubectl
    k9s
    kustomize
    kubernetes-helm
    kubectx
    kubie
    fluxcd
    kind
    ko
    cloud-provider-kind
    k9s
  ];
}
