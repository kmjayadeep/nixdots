{
  pkgs,
  inputs,
  ...
}: {

  home.packages = with pkgs; [
    kubectl
    k9s
    kustomize
    kubernetes-helm
  ];

}
