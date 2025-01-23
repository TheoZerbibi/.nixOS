{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    hyprpicker
    pywal
    swaynotificationcenter
    pavucontrol
    wlogout
    hypridle
    hyprlock
    wofi
  ];
}