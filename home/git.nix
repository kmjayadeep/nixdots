{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {

  # github cli
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

  programs.git = {
    enable = true;

    signing = {
      key = "E144EC9E6313D549";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "Jayadeep KM";
        email = "kmjayadeep@gmail.com";
      };
      pull = {
        ff = "only";
      };
    };
  };

  home.packages = with pkgs; [
    git-crypt
  ];
}
