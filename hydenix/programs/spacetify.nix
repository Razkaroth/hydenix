{ pkgs, inputs, lib, ... }:
let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  # allow spotify to be installed if you don't have unfree enabled already
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "spotify" ];

  # import the flake's module for your system
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  # configure spicetify :)
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.text;
    colorScheme = "mocha";

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      fullAppDisplayMod
      shuffle # shuffle+ (special characters are sanitized out of ext names)
      hidePodcasts
    ];
    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      lyricsPlus

    ];
  };
}
