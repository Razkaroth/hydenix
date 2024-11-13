{ ... }: {
  imports = [
    ./system.nix
    ./display-manager.nix
    ./window-manager.nix
    ./dependencies.nix
    ./theming.nix
    ./applications.nix
    ./dev.nix
    ./shell.nix
    ./gaming.nix
    ./music.nix
  ];
}
