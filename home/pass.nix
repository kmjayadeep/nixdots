{
  config,
  lib,
  inputs,
  ...
}: {
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "$HOME/private/password-store";
    };
  };
}
