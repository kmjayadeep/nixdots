{
  pkgs,
  inputs,
  ...
}: 

let
  gdk = pkgs.google-cloud-sdk.withExtraComponents( with pkgs.google-cloud-sdk.components; [
    gke-gcloud-auth-plugin
  ]);
in

{
  home.packages = with pkgs; [
    gdk
    helmfile
  ];
}
