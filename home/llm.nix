{pkgs, llm-agents, ...}: {
  home.packages = [
    llm-agents.opencode
    llm-agents.codex
    llm-agents.claude-code
    llm-agents.pi
  ];

  home.file.".config/opencode/commands/commit-push.md".source = ../assets/opencode/commit-push.md;
}
