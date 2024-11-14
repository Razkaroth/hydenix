{
  nixpkgs,
  home-manager,
  system,
  pkgs,
  userConfig,
  nix-index-database,
  zen-browser,
  nixarr,
  spicetify-nix,
  ...
}:
let 
  configuration = import ./configuration.nix { inherit pkgs userConfig; };
in nixpkgs.lib.nixosSystem {
  inherit system;

  modules = [
    nixarr.nixosModules.default
    configuration
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${userConfig.username} =
        { ... }:
        {
          imports = [
            ./home.nix
            nix-index-database.hmModules.nix-index
            spicetify-nix.homeManagerModules.default
          ] ++ userConfig.homeModules;
        };
      home-manager.extraSpecialArgs = {
        inherit userConfig zen-browser spicetify-nix;
      };
    }
  ] ++ userConfig.nixModules;
}
