{
  lib,
  pkgs,
  themes,
  userConfig,
}:
let
  hyde = import ../sources/hyde.nix { inherit pkgs; };
  wallbash-gtk = import ../sources/wallbash-gtk.nix { inherit pkgs lib; };
  spicetify-sleek = import ../sources/spicetify-sleek.nix { inherit pkgs lib; };
  hyde-gallery = import ../sources/hyde-gallery.nix { inherit pkgs lib; };
in

lib.mkMerge [

  # --------------------------------------------------- // Hyde-cli

  # --------------------------------------------------- // Hyde configurations
  {
    ".config" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".local/share" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.local/share";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".icons/default" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.icons/default";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".p10k.zsh" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.p10k.zsh";
      force = true;
      mutable = true;
    };
    ".gtkrc-2.0" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.gtkrc-2.0";
      force = true;
      mutable = true;
    };
  }

  # -------------------------------------------------- // Theming
  {
    # Wallbash GTK theme
    ".themes/Wallbash-Gtk" = {
      source = "${wallbash-gtk}/share/themes/Wallbash-Gtk";
      force = true;
      recursive = true;
      mutable = true;
    };
    # Spicetify Sleek theme
    ".config/spicetify/Themes/Sleek" = {
      source = "${spicetify-sleek}/share/spicetify/themes/Spicetify-Sleek";
      force = true;
      recursive = true;
      mutable = true;
    };
  }

  # --------------------------------------------------- // Cache files
  {
    # VSCode Wallbash extension
    ".cache/hyde/landing/Code_Wallbash.vsix" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Source/arcs/Code_Wallbash.vsix";
      force = true;
      mutable = true;
    };
    # Spotify Sleek theme (TODO: requires flatpak for Spotify)
    ".cache/hyde/landing/Spotify_Sleek.tar.gz" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Source/arcs/Spotify_Sleek.tar.gz";
      force = true;
      mutable = true;
    };
    # Hyde Gallery
    ".cache/hyde/landing/hyde-gallery" = {
      source = "${hyde-gallery}/share/hyde/hyde-gallery";
      force = true;
      recursive = true;
      mutable = true;
    };
  }

  # --------------------------------------------------- // User configurations
  {
    ".config/hyde/hyde.conf" = {
      text = import ./hyde-conf.nix { inherit userConfig; };
      force = true;
      mutable = true;
    };
  }

  {
    ".config/hypr/monitors.conf" = {
      text = import ./hypr-configs/monitors.nix { inherit userConfig; };
      force = true;
      mutable = true;
    };

  }

  # --------------------------------------------------- // Theme generation
  (import ./gen-theme-homefiles.nix { inherit lib pkgs; } themes)

]
