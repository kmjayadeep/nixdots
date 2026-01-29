{pkgs, ...}: {
  home.packages = [
    pkgs.opencode
  ];

  home.file.".config/opencode/commands/commit-push.md".source = ../assets/opencode/commit-push.md;
}
