{ pkgs, ... }: {

  imports = [ ./git.nix ./zsh.nix ./vscode.nix ./tmux.nix ];

  programs = {
    home-manager.enable = true;
    kitty.enable = true;
    waybar.enable = true;
    vscode.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    swaylock.enable = true;
    zsh.enable = true;
    nix-index.enable = true;
  };
}
