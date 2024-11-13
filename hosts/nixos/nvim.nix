{ lib, pkgs, neovimUtils, wrapNeovimUnstable, ... }:

let
  config = pkgs.neovimUtils.makeNeovimConfig {
    extraLuaPackages = p:
      with p; [
        # ... other lua packages
        p.magick # for image rendering
        p.tiktoken_core
      ];
    extraPython3Packages = p:
      with p; [
        pynvim
        jupyter-client
        cairosvg # for image rendering
        ipython
        nbformat
        # ... other python packages
      ];
    extraPackages = p:
      with p;
      [
        imageMagick # for image rendering
        # ... other packages
      ];
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;
    # https://github.com/NixOS/nixpkgs/issues/211998
    customRC = "luafile ~/.config/nvim/init.lua";
  };
in {
  nixpkgs.overlays = [
    (_: super: {
      neovim-custom = pkgs.wrapNeovimUnstable
        (super.neovim-unwrapped.overrideAttrs (oldAttrs: {
          buildInputs = oldAttrs.buildInputs ++ [ super.tree-sitter ];
        })) config;
    })
  ];

  environment.systemPackages = with pkgs; [
    neovim-custom

    # Can't install this with the rest of the python packages b/c this needs to be in path
    python3Packages.jupytext # if you want to use vim-jupytext or similar

    # ... other system packages
  ];
}
