rec {
  username = "raz";
  gitUser = "razkaroth";
  gitEmail = "rocker.ikaros@gmail.com";
  host = "Crystalix";
  /* Default password is required for sudo support in systems
     !REMEMBER TO USE passwd TO CHANGE THE PASSWORD!
  */
  defaultPassword = "hydenix";
  timezone = "America/Mexico_City";
  locale = "en_US.UTF-8";
  extraLocale = "es_MX.UTF-8";

  hyde = rec {
    sddmTheme = "Candy"; # or "Corners"

    enable = true;

    # git config, useful for initial setup
    git = {
      userName = "${username}";
      userEmail = "${gitEmail}";
    };

    # active theme, must be in themes list
    activeTheme = "Catppuccin Mocha";

    # list of themes to choose from
    themes = [
      # -- Default themes
      "Catppuccin Mocha"
      "Catppuccin Latte"
      "Decay Green"
      "Edge Runner"
      "Frosted Glass"
      "Graphite Mono"
      "Gruvbox Retro"
      "Material Sakura"
      "Nordic Blue"
      "Rose Pine"
      "Synth Wave"
      "Tokyo Night"

      # -- Themes from hyde-gallery (use with caution)
       "Abyssal-Wave"
       "AbyssGreen"
       "Bad Blood"
       "Cat Latte"
       "Dracula"
       "Edge Runner"
       "Green Lush"
       "Greenify"
       "Hack the Box"
       "Ice Age"
       "Mac OS"
       "Monokai"
       "One Dark"
       "Oxo Carbon"
       "Paranoid Sweet"
       "Rain Dark"
       "Red Stone"
       "Rose Pine"
       "Scarlet Night"
       "Sci-fi"
       "Solarized Dark"
       "Windows 11"
       # "Monterey Frost"
      # TODO: fix pixel dream icon build
      # "Pixel Dream"
    ];

    # Exactly the same as hyde.conf
    conf = {
      hydeTheme = activeTheme;
      wallFramerate = 144;
      wallTransDuration = 0.4;
      wallAddCustomPath = "";
      enableWallDcol = 2;
      wallbashCustomCurve = "";
      themeSelect = 2;
      rofiStyle = 11;
      rofiScale = 9;
      wlogoutStyle = 1;
    };
  };

  vm = {
    # 4 GB minimum
    memorySize = 8192;
    # 2 cores minimum
    cores = 4;
    # TODO: review, it also seems to matter which vm is run
    # 30GB minimum for one theme - 50GB for multiple themes - more for development and testing
    diskSize = 30000;
  };
 /*
    These will be imported after the default modules and override/merge any conflicting options
    !Its very possible to break hydenix by overriding options
    eg:
      # lets say hydenix has a default of:
      {
        services.openssh.enable = true;
        environment.systemPackages = [ pkgs.vim ];
      }
      # your module
      {
        services.openssh.enable = false;  #? This wins by default (last definition)
        environment.systemPackages = [ pkgs.git ];  #? This gets merged with hydenix
      }
  */
  # List of nix modules to import in ./hosts/nixos/default.nix
  nixModules = [
    # (toString ./my-module.nix)
    # in my-module.nix you can reference this userConfig
    # ({ userConfig, pkgs, ... }: {
    #   environment.systemPackages = [ pkgs.git ];
    # })
  ];
  # List of nix modules to import in ./lib/mkConfig.nix
  homeModules = [
   ];
}
