{ pkgs, spicetify-nix, ... }:
let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in {

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
