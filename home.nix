{ lib, config, pkgs, ... }:
{
  # Indique à Home Manager l’utilisateur "theo"
  home.username = lib.mkForce "theo";
  home.homeDirectory = lib.mkForce "/home/theo";

  # Active Home Manager
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Fichier ~/.config/hypr/hyprland.conf minimal
  home.file.".config/hypr/hyprland.conf".text = builtins.readFile ./hyprland.conf;
  # Paquets user (applicatifs pour "theo")
  home.packages = with pkgs; [
    firefox
    thunderbird
    vscode
    waybar
    swaybg
    kitty
    dolphin
    wofi
    brightnessctl
    playerctl
    hyprpaper
    anydesk
  ];

  # Version Home Manager
  home.stateVersion = "24.11";
}
