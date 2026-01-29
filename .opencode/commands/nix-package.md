---
description: Add or remove nix package
agent: build
---
Add or remove the requested Nix package in this repository (update the relevant package list files).
Use $ARGUMENTS to determine which package(s) to add or remove.

Verify the package exists in nixpkgs.
- Preferred: `nix search nixpkgs <package>`
- If search.nixos.org is usable, confirm there too: https://search.nixos.org/packages?channel=unstable&query=<package name>
