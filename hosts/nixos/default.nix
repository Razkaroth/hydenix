{ nixpkgs, home-manager, system, pkgs, userConfig, nix-index-database, nixarr
, ... }:

nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = {
    inherit pkgs;
    inherit userConfig;
  };
  modules = [
    ./configuration.nix
    home-manager.nixosModules.home-manager

    nixarr.nixosModules.default
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${userConfig.username} = { pkgs, ... }: {
        imports = [ ./home.nix nix-index-database.hmModules.nix-index ];
      };
      home-manager.extraSpecialArgs = { inherit userConfig; };
    }
  ];
}
