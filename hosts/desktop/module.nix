{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    hyprpicker
    pywal
    swaynotificationcenter
    pavucontrol
    wlogout
    hyprlock
    wofi
    rofi-wayland
    libnotify
    home-manager
    swww
    cava
  ];
}