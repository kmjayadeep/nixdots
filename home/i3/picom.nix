{
  config,
  lib,
  inputs,
  ...
}: {
  services.picom = {
    enable = true;
    backend = "glx";
    fadeExclude = [
      "class_g = 'xsecurelock'"
    ];
  };
}
