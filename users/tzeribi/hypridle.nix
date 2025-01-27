{ lib, pkgs, ... }:
{
  systemd.user.services.hypridle = {

    serviceConfig = {
      ExecStart = "${pkgs.hypridle}/bin/hypridle --config $HOME/.cache/wal/colors-hyprland";
      Restart = "always";
      RestartSec = "5s";
    };

    wantedBy = [ "default.target" ];
  };
}
