{pkgs, ...}: {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.nix-collect-garbage = {
    enable = true;
    runOnBoot = true;
    runOnSchedule = "daily";
    extraOptions = [ "--delete-older-than" "14d" ];
  };
}