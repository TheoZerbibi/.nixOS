{ lib, ... }:
{
  programs.hypridle = {
    enable = true;

    settings = {
      source = "/home/tzeribi/.cache/wal/colors-hyprland";

      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        ignore_dbus_inhibit = "/opt/spotify/spotify";
      };

      listeners = [
        {
          timeout = 270;
          on_timeout = ''
            source "/home/tzeribi/.cache/wal/colors-hyprland"
            notify-send "System" "You are about to be locked out!" -i $wallpaper
          '';
        }
        {
          timeout = 600;
          on_timeout = "loginctl lock-session";
          on_resume = ''
            sleep 2
            source "/home/tzeribi/.cache/wal/colors-hyprland"
            notify-send "System" "Unlocked! Hey Théo" -i $wallpaper
          '';
        }
        {
          timeout = 1200;
          on_timeout = "hyprctl dispatch dpms off";
          on_resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
