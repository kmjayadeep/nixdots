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
    # Run notmuch indexer
    postExec = "${pkgs.notmuch}/bin/notmuch new";
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
        notmuch = {
          enable = true;
          neomutt.enable = true; # Use notmuch virtual mailboxes in neomutt
        };

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
        passwordCommand = "${pkgs.pass}/bin/pass mutt/jayadeepkm99@gmail.com";

        msmtp = {
          enable = true;
        };

        neomutt = {
          enable = true;
        };
      };

      "zoho-temp" = {
        address = "mail@jayadeep.me";
        realName = "Jayadeep KM";

        flavor = "plain";
        userName = "mail@jayadeep.me";

        smtp = {
          host = "smtp.zoho.com";
          port = 587;
        };
        imap = {
          host = "imap.zoho.com";
          port = 993;
        };

        notmuch = {
          enable = true;
          neomutt.enable = true; # Use notmuch virtual mailboxes in neomutt
        };

        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          remove = "both";

          patterns = [
            "*"
          ];
        };

        passwordCommand = "${pkgs.pass}/bin/pass mutt/zoho-temp";

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
