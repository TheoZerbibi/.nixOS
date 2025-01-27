{ lib, pkgs, ... }:
{
  systemd.user.services.hypridle = {
    enable = true;
    description = "Hypridle idle management service";

    serviceConfig = {
      ExecStart = "${pkgs.hypridle}/bin/hypridle --config $HOME/.cache/wal/colors-hyprland";
      Restart = "always";
      RestartSec = "5s";
    };

    wantedBy = [ "default.target" ];
  };
}
