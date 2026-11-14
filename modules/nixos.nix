{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Nix settings, auto cleanup and enable flakes
  nix = {
    settings = {
      # Performance optimizations
      max-jobs = "auto"; # Use all available cores for building
      cores = 0; # Use all available cores per job
      auto-optimise-store = true; # Automatically optimize store
      allowed-users = ["jayadeep"];

      # Binary cache configuration for faster builds
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://cache.numtide.com"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      ];

      # Build optimization
      builders-use-substitutes = true; # Allow builders to use substitutes

      # Auto-GC during builds when free space drops below 10G, until 50G free
      min-free = 10 * 1024 * 1024 * 1024;
      max-free = 50 * 1024 * 1024 * 1024;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
