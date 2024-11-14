{
  description =
    "Nix & home-manager configuration for HyDE, an Arch Linux based Hyprland desktop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:MarceColl/zen-browser-flake";
    nixarr.url = "github:rasmus-kirk/nixarr";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, home-manager,  nix-index-database, zen-browser, nixarr, spicetify-nix, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      mkNixosHost = import ./hosts/nixos;
      nix-vm = import ./hosts/vm/nix-vm.nix;
      userConfig = import ./config.nix;

      commonArgs = {
        inherit nixpkgs pkgs home-manager system userConfig nix-index-database zen-browser nixarr spicetify-nix;
      };
      arch-vm = import ./hosts/vm/arch-vm.nix { inherit pkgs userConfig; };
      fedora-vm = import ./hosts/vm/fedora-vm.nix { inherit pkgs userConfig; };

      devShell = import ./lib/dev-shell.nix { inherit commonArgs; };
    in {
      nixosConfigurations = {
        hydenix = mkNixosHost commonArgs;

        nix-vm = nix-vm {
          inherit userConfig;
          nixosSystem = mkNixosHost commonArgs;
        };
      };

      packages.${system} = {
        default = self.nixosConfigurations.nix-vm.config.system.build.vm;
        nix-vm = self.nixosConfigurations.nix-vm.config.system.build.vm;
        hydenix = self.nixosConfigurations.hydenix.config.system.build.toplevel;

        # EXPERIMENTAL VM BUILDERS
        arch-vm = arch-vm;
        fedora-vm = fedora-vm;
      };

      # import for customized home-manager configurations
      homeManagerModules.default = {
        ${userConfig.username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules =
            [ ./hosts/nixos/home.nix nix-index-database.hmModules.nix-index ];
          extraSpecialArgs = {
            inherit userConfig;
            inherit inputs;
          };
        };
      };

      # only to be used on non-NixOS systems
      homeConfigurations = {
        "${userConfig.username}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/nixos/home.nix
            nix-index-database.hmModules.nix-index
            { targets.genericLinux.enable = true; }
          ];
          extraSpecialArgs = {
            inherit userConfig;
            inherit inputs;
          };
        };
        activationPackage =
          self.homeConfigurations.${userConfig.username}.activationPackage;
      };

      devShells.${system}.default = devShell;
    };
}
