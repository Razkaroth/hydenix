{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # --------------------------------------------------- // Applications
    firefox # browser
    brave # browser
    betterbird
    chromium # browser
    google-chrome # browser
    kitty # terminal
    libsForQt5.dolphin # kde file manager
    ark # kde file archiver
    vim # terminal text editor
    vscode # ide text editor
    discord # chat client
    webcord # discord client
    vesktop # discord client
    pomodoro
    sunvox
    obsidian
    obs-studio
    thunderbird-bin
    typora
    transmission_4-gtk
    libreoffice
    signal-desktop # messaging client
    zoom-us # video conferencing
  ];
}
