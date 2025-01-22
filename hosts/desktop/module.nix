{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    hyprpicker
    pywal
    swaync
  ];
}