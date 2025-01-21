{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    # Module NixOS de Home Manager
    inputs.home-manager.nixosModules.default

    # Module local créant l’utilisateur "theo" (root)
    ./main-user.nix
  ];

  #### Main user "theo" (root)
  main-user.enable = true;
  main-user.userName = "theo";

  #### Home Manager pour l’utilisateur "theo"
  home-manager.users = {
    theo = lib.mkForce (import ./home.nix);
  };

  #### Bootloader & EFI
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #### Autoriser logiciels non-libres (ex: NVIDIA, polices Microsoft...)
  nixpkgs.config.allowUnfree = true;

  #### Activer Nix Command & Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #### Réseau
  networking.networkmanager.enable = true;
  networking.hostName = "theo-invisensing";

  #### Locales
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT    = "fr_FR.UTF-8";
    LC_MONETARY       = "fr_FR.UTF-8";
    LC_NAME           = "fr_FR.UTF-8";
    LC_NUMERIC        = "fr_FR.UTF-8";
    LC_PAPER          = "fr_FR.UTF-8";
    LC_TELEPHONE      = "fr_FR.UTF-8";
    LC_TIME           = "fr_FR.UTF-8";
  };

  #### X11 & SDDM
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;

  # Optionnel : Auto-login direct sur Hyprland pour "theo"
  # services.xserver.displayManager.sddm.autoLogin.enable = true;
  # services.xserver.displayManager.sddm.autoLogin.user = "theo";
  # services.xserver.displayManager.sddm.autoLogin.session = "Hyprland";

  #### Hyprland au niveau système
  programs.hyprland = {
    enable = true;
    # On utilise la dérivation Hyprland du flake
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };
  programs.zsh.enable = true;
  hardware.enableAllFirmware = true;
  boot.kernelModules = [ "iwlwifi" ];
  #### Audio (Pipewire)
  hardware.graphics.enable = true;
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  #### Paquets système
  environment.systemPackages = with pkgs; [
    wget
    pulseaudio
    pamixer
    networkmanager
    upower
    vim
    unzip
    curl
    git
    zsh
    font-awesome
    noto-fonts
    nerd-fonts.fira-code
    nerd-fonts.roboto-mono 
  ];

  #### stateVersion
  system.stateVersion = "24.11";
}
