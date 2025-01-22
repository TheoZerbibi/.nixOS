{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    blueman
    bluez
  ];
  hardware.bluetooth.enable = true; 
}