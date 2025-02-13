{...}: {
  console.useXkbConfig = true;
  services.xserver.xkb = {
    layout = "us";
    options = "alt_shift_toggle";
  };
  services.xserver.enable = false;

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  time.timeZone = "Europe/Paris";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };
}