
{
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs.ledger = {
    enable = true;
    settings =  {
      date-format = "%Y-%m-%d";
      file = [
        "~/private/psuite/ledger/accounts.ledger"
        "~/private/psuite/ledger/journal.ledger"
      ];
      sort = "date";
      strict = true;
    };
  };
  home.packages = with pkgs; [
    beancount
    ledger2beancount
    fava
  ];
}
