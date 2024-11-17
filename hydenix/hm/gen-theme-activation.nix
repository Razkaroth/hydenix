{
  lib,
  pkgs,
  activeTheme,
}:
# TODO: themeswitch functionality within nix
let
  # Helper function to cut first line of theme files
  processThemeFile =
    file:
    let
      content = builtins.readFile file;
      lines = lib.splitString "\n" content;
      processedLines = builtins.tail lines;
    in
    pkgs.writeText "processed-theme" (lib.concatStringsSep "\n" processedLines);
in

{
  # Copies sourcemaps related to active theme to overwrite defaults toprevent flashing
  ".config/Kvantum/wallbash/wallbash.svg" = {
    source = processThemeFile "${activeTheme.pkg}/share/hyde/themes/${activeTheme.name}/kvantum/kvantum.theme";
    force = true;
    mutable = true;
  };
  ".config/Kvantum/wallbash/wallbash.kvconfig" = {
    source = processThemeFile "${activeTheme.pkg}/share/hyde/themes/${activeTheme.name}/kvantum/kvconfig.theme";
    force = true;
    mutable = true;
  };
  ".config/hypr/themes/theme.conf" = {
    source = processThemeFile "${activeTheme.pkg}/share/hyde/themes/${activeTheme.name}/hypr.theme";
    force = true;
    mutable = true;
  };
  ".config/kitty/theme.conf" = {
    source = processThemeFile "${activeTheme.pkg}/share/hyde/themes/${activeTheme.name}/kitty.theme";
    force = true;
    mutable = true;
  };
  ".config/rofi/theme.rasi" = {
    source = processThemeFile "${activeTheme.pkg}/share/hyde/themes/${activeTheme.name}/rofi.theme";
    force = true;
    mutable = true;
  };
  ".config/waybar/theme.css" = {
    source = processThemeFile "${activeTheme.pkg}/share/hyde/themes/${activeTheme.name}/waybar.theme";
    force = true;
    mutable = true;
  };
}
