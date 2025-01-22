{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    blueman
    bluez
  ];
  services.bluetooth.enable = true;
  hardware.bluetooth.enable = true; 
}