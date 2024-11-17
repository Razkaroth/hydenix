{
  lib,
  pkgs,
  themes,
  userConfig,
  activeTheme,
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
    ".config/Code - OSS/User" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/Code - OSS/User";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/Code/User" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/Code/User";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/Kvantum" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/Kvantum";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/MangoHud" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/MangoHud";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/dunst" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/dunst";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/fastfetch" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/fastfetch";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/fish" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/fish";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/gtk-3.0" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/gtk-3.0";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/hyde" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/hyde";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/hypr" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/hypr";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/kitty" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/kitty";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/lsd" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/lsd";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/menus" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/menus";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/nwg-look" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/nwg-look";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/qt5ct" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/qt5ct";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/qt6ct" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/qt6ct";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/rofi" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/rofi";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/swaylock" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/swaylock";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/waybar" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/waybar";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/wlogout" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/wlogout";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".config/xsettingsd" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/xsettingsd";
      force = true;
      recursive = true;
      mutable = true;
    };

    ".config/baloofilerc" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/baloofilerc";
      force = true;
      mutable = true;
    };
    ".config/code-flags.conf" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/code-flags.conf";
      force = true;
      mutable = true;
    };
    ".config/dolphinrc" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/dolphinrc";
      force = true;
      mutable = true;
    };
    ".config/kdeglobals" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/kdeglobals";
      force = true;
      mutable = true;
    };
    ".config/libinput-gestures.conf" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/libinput-gestures.conf";
      force = true;
      mutable = true;
    };
    ".config/spotify-flags.conf" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.config/spotify-flags.conf";
      force = true;
      mutable = true;
    };

    ".local/share/bin" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.local/share/bin";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".local/share/dolphin" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.local/share/dolphin";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".local/share/kio/servicemenus" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.local/share/kio/servicemenus";
      force = true;
      recursive = true;
      mutable = true;
    };
    ".local/share/kxmlgui5/dolphin" = {
      source = "${hyde}/share/hyde/hyprdots-modified/Configs/.local/share/kxmlgui5/dolphin";
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

  # --------------------------------------------------- // Theme generation
  (import ./gen-theme-homefiles.nix { inherit lib pkgs; } themes)

  # --------------------------------------------------- // Theme activation
  (import ./gen-theme-activation.nix { inherit lib pkgs activeTheme; })

]
