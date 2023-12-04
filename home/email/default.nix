{ config, lib, pkgs, ... }:

{
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.notmuch.enable = true;

  accounts.email.accounts = {
    "jayadeepkm99" = {
      address = "jayadeepkm99@gmail.com";
      realName = "Jayadeep KM";
      primary = true;
      flavor = "gmail.com";
      notmuch.enable = true;

      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
        remove = "both";

        patterns = [
          "*"
          "![Gmail]*"
        ];
      };
      passwordCommand = "gpg -q --decrypt ~/private/mail/jayadeepkm99.asc";

      msmtp = {
        enable = true;
      };
    };
  };

  home.file.".private/mail/jayadeepkm99.asc".source = ./files/jayadeepkm99.gpg;
  home.file.".private/mail/signature".source = ./files/signature;
}
