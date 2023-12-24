{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.msmtp.enable = true;
  programs.notmuch.enable = true;

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
          ];
        };

        passwordCommand = "PASSWORD_STORE_DIR=$HOME/private/password-store GNUPGHOME=$HOME/private/gpg  ${pkgs.pass}/bin/pass mutt/jayadeepkm99@gmail.com";

        msmtp = {
          enable = true;
        };

        neomutt = {
          enable = true;
        };
      };

      "personal" = {
        address = "kmjayadeep@zohomail.com";
        realName = "Jayadeep KM";

        flavor = "plain";
        userName = "kmjayadeep@zohomail.com";

        smtp = {
          host = "smtp.zoho.com";
          port = 587;
          tls.useStartTls = true;
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

        passwordCommand = "PASSWORD_STORE_DIR=$HOME/private/password-store GNUPGHOME=$HOME/private/gpg ${pkgs.pass}/bin/pass mutt/kmjayadeep@zohomail.com";

        msmtp = {
          enable = true;
        };

        neomutt = {
          enable = true;
        };
      };
    };
  };

  programs.neomutt = {
    enable = true;
    vimKeys = true;
    sidebar.enable = true;
  };

  home.file."private/mail/secrets/signature".source = ./files/signature;
}
