{ hostname, ... }: {
  networking.networkmanager.enable = true;
  networking.networkmanager.wait-online.enable = false;

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };
}