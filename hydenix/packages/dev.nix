{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # --------------------------------------------------- // Software Development

    # k8s
    kubectl
    lens
    kubernetes-helm
    #Cloud
    doctl

    # Tools

    aria2
    bat
    anydesk
    fd
    ripgrep
    fzf
    socat
    ffmpeg
    docker
    docker-compose
    jq
    git-lfs
    postman
    insomnia
    speedtest-cli
    zoxide

    #DB
    sqlite
    sqlitebrowser
    mongodb-compass

    # langs
    nodejs
    corepack
    gjs
    bun
    cargo
    go
    gcc
    gnumake
    cmakeMinimal
    typescript
    eslint
    # very important stuff
    uwuify
    neofetch
    thefuck
  ];
}
