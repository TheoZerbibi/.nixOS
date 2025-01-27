{pkgs, config, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment.systemPackages = with pkgs; [
    curl
    git
    wget
  ];

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "code";
    PATH = "${pkgs.home-manager}/bin:${config.environment.systemPackages}/bin";
  };
}