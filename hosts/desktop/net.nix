{hostname, ...}: {

  environment.systemPackages = with pkgs; [
    networkmanager
  ];
  networking.networkmanager.enable = true;

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };
}