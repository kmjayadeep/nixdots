{ config, lib, pkgs, ... }:

{

  programs.msmtp.enable = true;
  programs.notmuch.enable = true;
  programs.neomutt.enable = true;

  programs.mbsync.enable = true;
  services.mbsync = {
    enable = true;
    # Run every 2 mins
    frequency = "*:0/2";
  };

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
        passwordCommand = "${pkgs.gnupg}/bin/gpg -q --yes --decrypt ~/private/mail/secrets/jayadeepkm99.asc";

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
