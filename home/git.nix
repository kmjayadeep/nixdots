{
  config,
  lib,
  inputs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "Jayadeep KM";
    userEmail = "kmjayadeep@gmail.com";

    signing = {
      key = "E144EC9E6313D549";
      signByDefault = true;
    };

    extraConfig = {
      pull = {
        ff = "only";
      };
    };
  };
}
