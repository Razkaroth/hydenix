#!/bin/sh
echo " Rebuild the system with the current flake"

sudo nixos-rebuild switch --flake .#hydenix

echo "Appending extra configuration to the hyprland monitor configs"

echo "source = ./monitorsRaz.conf" >>"$HOME/.config/hypr/monitors.conf"
