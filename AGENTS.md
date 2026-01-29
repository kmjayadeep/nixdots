# Repository Guidelines

## Project Structure & Module Organization

- `flake.nix` / `flake.lock`: Nix flake entrypoint and pinned inputs.
- `hosts/`: Host-specific NixOS configs (e.g., `hosts/jd-vm`, `hosts/jd-pc`).
- `home/`: Home Manager configuration and app configs (e.g., `home/nvim`, `home/kitty`).
- `modules/`: Reusable Nix modules shared across hosts.
- `assets/`: Static assets used by configs.

## Build, Test, and Development Commands

- `sudo nixos-rebuild switch --flake .#jd-vm --fast`  
  Build and activate a host configuration (replace `jd-vm` with another host in `hosts/`).
- `nix flake update`  
  Update flake inputs in `flake.lock`.

This repo does not define a standalone test runner; rebuilds are the primary validation step.

## Coding Style & Naming Conventions

- Nix files use 2-space indentation and idiomatic Nix formatting.
- Format Nix code with `alejandra` (installed via `home/packages.nix`).  
  Example: `alejandra flake.nix home/*.nix`
- Naming is short and practical; host directories follow `jd-*` pattern as seen in `hosts/`.

## Testing Guidelines

- No dedicated test framework is configured.
- Validate changes by rebuilding the target host and ensuring the system boots and user services load.

## Commit & Pull Request Guidelines

- Commit messages are short, lowercase, and imperative (examples from history: `flake update`, `install opencode`, `fix treesitter nvim`).
- Keep commits focused on one change set (host, module, or app config).
- PRs (if used) should include:
  - A brief summary of intent and affected hosts.
  - Rebuild command used (e.g., `nixos-rebuild` with target host).
  - Screenshots only when UI changes are visible (e.g., `home/rofi`, `home/wlogout`).

## Security & Configuration Tips

- Hardware-specific configuration lives under `hosts/`; do not reuse without adjusting hardware settings.
- Secrets should not be committed; keep machine-specific secrets outside this repo.
