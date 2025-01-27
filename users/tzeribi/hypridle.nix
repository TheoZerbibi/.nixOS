{ lib, config, pkgs, ... }:
{
  systemd.user.services.hypridle = {
    enable = true;
    description = "Hypridle idle management service";

    ExecStart = "${pkgs.hypridle}/bin/hypridle --config ${config.home.homeDirectory}/.config/hypridle/config";

    Restart = "always";
    RestartSec = "5s";
  };

  home.file.".config/hypridle/config".text = ''
    source "${config.home.homeDirectory}/.cache/wal/colors-hyprland"

    general {
        lock_cmd = "pidof hyprlock || hyprlock"
        ignore_dbus_inhibit = "/opt/spotify/spotify"
    }

    listener {
        timeout = 270
        on-timeout = 'source "${config.home.homeDirectory}/.cache/wal/colors-hyprland" && notify-send "System" "You are about to be locked out!" -i "$wallpaper"'
    }

    listener {
        timeout = 600
        on-timeout = "loginctl lock-session"
        on-resume = 'sleep 2 && source "${config.home.homeDirectory}/.cache/wal/colors-hyprland" && notify-send "System" "Unlocked! Hey $USER" -i "$wallpaper"'
    }

    listener {
        timeout = 1200
        on-timeout = "hyprctl dispatch dpms off"
        on-resume = "hyprctl dispatch dpms on"
    }
  '';
}
