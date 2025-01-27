{ config, pkgs, ... }: {
  networking.hostName = "theo-invisensing";

  networking.networkmanager.enable = true;

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };
}
