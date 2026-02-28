{pkgs, llm-agents, ...}: {
  home.packages = [
    llm-agents.opencode
    llm-agents.codex
  ];

  home.file.".config/opencode/commands/commit-push.md".source = ../assets/opencode/commit-push.md;
}
