{
  description = "NixOS configuration";

  # All inputs for the system
  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Temporarily until https://github.com/NixOS/nixpkgs/issues/368672 is resolved
    nixpkgs.url = "github:nixos/nixpkgs/585f76290ed66a3fdc5aae0933b73f9fd3dca7e3";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    go-todo-exporter = {
      url = "github:kmjayadeep/go-todo-exporter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My bash scripts
    scripts = {
      url = "github:kmjayadeep/scripts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # All outputs for the system (configs)
  outputs = {
    home-manager,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux"; #current system
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    lib = nixpkgs.lib;
    go-todo-exporter = inputs.go-todo-exporter.packages.${system};
    scripts = inputs.scripts.packages.${system};

    # This lets us reuse the code to "create" a system
    # Credits go to sioodmy on this one!
    # https://github.com/sioodmy/dotfiles/blob/main/flake.nix
    mkSystem = pkgs: system: hostname:
      pkgs.lib.nixosSystem {
        system = system;
        modules = [
          {networking.hostName = hostname;}
          # Host specific config (bootloader, kernel modules, filesystems, etc)
          # DO NOT USE MY HARDWARE CONFIG!! USE YOUR OWN!!
          (./. + "/hosts/${hostname}")
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              backupFileExtension = "back";
              extraSpecialArgs = {
                inherit inputs;
                go-todo-exporter = go-todo-exporter;
                scripts = scripts;
              };
              # Home manager config (configures user specific stuff like shell, aliases etc)
              users.jayadeep = ./home;
            };
          }
        ];
        specialArgs = {inherit inputs;};
      };
  in {
    nixosConfigurations = {
      # Now, defining a new system is can be done in one line
      #                                Architecture   Hostname
      jd-nuc = mkSystem inputs.nixpkgs "x86_64-linux" "jd-nuc";
      jd-vm = mkSystem inputs.nixpkgs "x86_64-linux" "jd-vm";
      jd-thinkpad = mkSystem inputs.nixpkgs "x86_64-linux" "jd-thinkpad";
      jd-pc = mkSystem inputs.nixpkgs "x86_64-linux" "jd-pc";

      # On proxmox
      jd-pve = mkSystem inputs.nixpkgs "x86_64-linux" "jd-pve";
    };
  };
}
