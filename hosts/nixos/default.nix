{
  nixpkgs,
  home-manager,
  system,
  pkgs,
  userConfig,
  nix-index-database,
  zen-browser,
  nixarr
}:

nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = {
    inherit pkgs;
    inherit userConfig;
  };
  modules = [
    ./configuration.nix
    ./kanata
    ./docker.nix
    ./tailscale.nix
    nixarr.nixosModules.default
    ./nixarr.nix
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${userConfig.username} =
        { pkgs, ... }:
        {
          imports = [
            ./home.nix
            nix-index-database.hmModules.nix-index
          ];
        };
      home-manager.extraSpecialArgs = {
        inherit userConfig zen-browser;
      };
    }
  ];
}
