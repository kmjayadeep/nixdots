{
  config,
  lib,
  inputs,
  ...
}: {
  programs.rbw = {
    enable = true;
    settings.email = "kmjayadeep@gmail.com";
  };
}
