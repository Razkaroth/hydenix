{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # --------------------------------------------------- // Applications
    firefox # browser
    brave # browser
    chromium # browser
    google-chrome # browser
    inputs.zen-browser.packages."${system}".specific
    kitty # terminal
    libsForQt5.dolphin # kde file manager
    ark # kde file archiver
    vim # terminal text editor
    vscode # ide text editor

    pomodoro
    sunvox
    obsidian
    obs-studio
    typora
    transmission_4-gtk
    libreoffice
    signal-desktop # messaging client
    discord # chat client
    webcord # discord client
    vesktop # discord client
    zoom-us # video conferencing
  ];
}
