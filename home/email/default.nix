{ config, lib, pkgs, ... }:

{
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.notmuch.enable = true;
  programs.neomutt.enable = true;

  accounts.email = {
    # Relative to home
    maildirBasePath = "private/mail/accounts";

    accounts = {
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
        passwordCommand = "gpg -q --decrypt ~/private/mail/secrets/jayadeepkm99.asc";

        msmtp = {
          enable = true;
        };

        neomutt = {
          enable = true;
        };
      };

    };

  };

  home.file."private/mail/secrets/jayadeepkm99.asc".source = ./files/jayadeepkm99.asc;
  home.file."private/mail/secrets/signature".source = ./files/signature;
}
