{ pkgs, lib, ... }:

let
  buildInputs = with pkgs; [
    coreutils
    findutils
    jq
    git
    kitty
    gnumake
    curl
    bash
    which
    sudo
    fzf
    tree
    jetbrains-mono
    gawk
    parallel
    gnutar
  ];

  pkg = pkgs.stdenv.mkDerivation {
    name = "hyde-cli";
    version = "master";
    src = pkgs.fetchFromGitHub {
      owner = "HyDE-Project";
      repo = "Hyde-cli";
      rev = "refs/tags/v0.6.0";
      name = "hyde-cli";
      sha256 = "sha256-aMMTurz+7QbId3S8jYhWhiA/ZS/L3TbII9/PPD1f+tg=";
    };

    nativeBuildInputs = with pkgs; [
      makeWrapper
      git
    ];

    makeFlags = [ "LOCAL=1" ];

    # TODO: sddm support by editing path in hyde-cli, then referencing path in sddm module
    buildPhase = ''

      # ------------ edits ------------ #

         # ensure all hyprdots scripts are executable
        find . -type f -executable -print0 | xargs -0 -I {} sed -i '1s|^#!.*|#!/usr/bin/env bash|' {}

        # Update waybar killall command in all hyprdots files
        find . -type f -print0 | xargs -0 sed -i 's/killall waybar/killall .waybar-wrapped/g'

        # update dunst
        find . -type f -print0 | xargs -0 sed -i 's/killall dunst/killall .dunst-wrapped/g'

        # update kitty
        find . -type f -print0 | xargs -0 sed -i 's/killall -SIGUSR1 kitty/killall -SIGUSR1 .kitty-wrapped/g'

       # scripts need to use dconf instead of gsettings
       find . -type f -not -name 'themepatcher.sh' -exec sed -i \
         -e 's/gsettings set/dconf write/g' \
         -e 's/gsettings get/dconf read/g' \
         -e 's/org\.gnome\.desktop\.interface \([^ ]*\)/\/org\/gnome\/desktop\/interface\/\1/g' \
         -e 's/org\.gnome\.desktop\.gtk \([^ ]*\)/\/org\/gnome\/desktop\/gtk\/\1/g' \
         -e 's/\(dconf write.*font-name\) '"'"'\([^'"'"']*\)'"'"'/\1 "'"'"'\2'"'"'"/' \
         -e 's/\(dconf write.*cursor-theme\) '"'"'\([^'"'"']*\)'"'"'/\1 "'"'"'\2'"'"'"/' \
         -e 's/\(dconf write.*color-scheme\) '"'"'\([^'"'"']*\)'"'"'/\1 "'"'"'\2'"'"'"/' \
         -e 's/\(dconf write.*gtk-theme\) '"'"'\([^'"'"']*\)'"'"'/\1 "'"'"'\2'"'"'"/' \
         -e 's/\(dconf write.*icon-theme\) '"'"'\([^'"'"']*\)'"'"'/\1 "'"'"'\2'"'"'"/' \
         -e 's/\(dconf write.*[^ ]*\) '"'"'\(\$[A-Za-z_][A-Za-z0-9_]*\)'"'"'/\1 "\2"/g' \
         -e 's/\(dconf write.*[^ ]*\) \(\$[A-Za-z_][A-Za-z0-9_]*\)/\1 "\2"/g' \
         {} +

         # add home-manager case to scripts
         find . -type f \( -name "*.sh" -o -executable \) -exec sed -i '/^if \[ -d \/run\/current-system\/sw\/share\/themes/,/else/c\if [ -d /run/current-system/sw/share/themes ] ; then\n    themeDir=/run/current-system/sw/share/themes\nelif [ -d ~/.local/state/nix/profiles/home-manager/home-path/share/themes ] ; then\n    themeDir=~/.local/state/nix/profiles/home-manager/home-path/share/themes\nelse' {} \;

        # delete line 169 from Patch-Theme
        sed -i '169d' ./Scripts/Patch-Theme

         # find needs -L to follow symlinks
        find . -type f -executable -print0 | xargs -0 sed -i 's/find "/find -L "/g'
        find . -type f -name "*.sh" -print0 | xargs -0 sed -i 's/find "/find -L "/g'

        # SDDM support - replace theme paths in Manage-SDDM script
        sed -i 's|/usr/share/sddm/themes|/run/current-system/sw/share/sddm/themes|g' ./Scripts/Manage-Sddm
        sed -i 's/find "/find -L "/g' ./Scripts/Manage-Sddm
        
        
      # ------------- end edits ------------ #;

        mkdir -p $out/share/hyde/hyde-cli
        cp -r . $out/share/hyde/hyde-cli
        mkdir -p $out/bin

        # Install Hyde, Hyde-install, and Hyde-tool
        install -m 755 Hyde $out/bin/Hyde
        install -m 755 Hyde-install $out/bin/Hyde-install
        install -m 755 Hyde-tool $out/bin/Hyde-tool

        # Create necessary directories
        mkdir -p $out/lib/hyde-cli
        mkdir -p $out/etc/hyde-cli
        mkdir -p $out/share/hyde-cli

        # Install scripts, configs, and extras
        cp -r Scripts/* $out/lib/hyde-cli/
        cp -r Configs/* $out/etc/hyde-cli/
        cp -r Extras/* $out/share/hyde-cli/

        # TODO: generate hyde meta file manually
        # remove set_metadata lines from all scripts in hyde-cli
        sed -i '/set_metadata/d' $out/lib/hyde-cli/Manage-Config
        sed -i '/set_metadata/d' $out/bin/Hyde-install
        sed -i '/set_metadata/d' $out/bin/Hyde

        # make all scripts executable
        chmod +x $out/lib/hyde-cli/*

        # Wrap executables
        wrapProgram $out/bin/Hyde \
          --prefix PATH : ${lib.makeBinPath buildInputs}
        wrapProgram $out/bin/Hyde-install \
          --prefix PATH : ${lib.makeBinPath buildInputs}
        wrapProgram $out/bin/Hyde-tool \
          --prefix PATH : ${lib.makeBinPath buildInputs}

        # make .hyde-cli.version file
        echo "HyDE CLI version 0.6.0" > $out/share/hyde/hyde-cli/.hyde-cli.ver
        echo "HyDE CLI version 0.6.0" > $out/share/hyde-cli/.hyde-cli.ver


    '';

    passthru = {
      inherit buildInputs;
    };

    installPhase = "true";

    postInstall = ''
      mkdir -p $out/share/applications
      cp $out/share/hyde/hyde-cli/Hyde.desktop $out/share/applications/
    '';
  };
in
pkg
