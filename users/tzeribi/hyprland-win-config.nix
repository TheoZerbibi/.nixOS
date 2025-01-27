{ lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      env = [
        "XCURSOR_THEME=Bibata-Modern-Classic"
        "XCURSOR_SIZE=12"
      ];
      source = lib.mkDefault "$HOME/.cache/wal/colors-hyprland";
      monitor = "DP-1, 2560x1440@165, 0x0, 1";
      input = {
        kb_layout = "us";
        kb_options = "alt_shift_toggle";
        numlock_by_default = true;
        follow_mouse = 1;
        sensitivity = 0;
        touchpad.natural_scroll = true;
      };
      general = {
        layout = "dwindle";
        resize_on_border = true;
        border_size = 1;
        gaps_in = 2;
        gaps_out = 15;
      };
      decoration = {
        rounding = 10;
        active_opacity = 0.8;
        inactive_opacity = 0.7;
        fullscreen_opacity = 1;
        blur = {
          enabled = true;
          size = 3;
          passes = 5;
          new_optimizations = true;
          ignore_opacity = true;
          xray = false;
          popups = true;
        };
        shadow = {
          enabled = true;
          range = 5;
          render_power = 2;
          color = "#1e1e2e";
        };
      };
      animations = {
        enabled = true;
        bezier = [
          "linear, 0,0,1,1"
          "swirl, 0.04, 1, 0.2, 1.2"
        ];
        animation = [
          "windows, 1, 4, swirl, popin 0%"
          "windowsOut, 1, 3, linear, popin 0%"
          "fade, 1, 2, linear"
          "workspaces, 1, 2, linear"
          "specialWorkspace, 1, 5, swirl, slidefadevert -50%"
        ];
      };
      dwindle.preserve_split = true;
      misc = {
        force_default_wallpaper = 1;
        disable_hyprland_logo = true;
      };
      exec-once = [
        "~/.config/waybar/scripts/wallpapers.sh"
        "hypridle"
        "waybar"
        "swww-daemon"
        "sudo powertop --auto-tune"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "swaync"
        "swaync-client -df"
        "pactl set-sink-mute @DEFAULT_SINK@ 0"
      ];
      layerrule = [
        "blur, waybar"
        "ignorezero, waybar"
        "ignorealpha 0.5, waybar"
        "ignorezero, swaync-control-center"
        "ignorezero, swaync-notification-window"
        "ignorealpha 0.5, swaync-control-center"
        "ignorealpha 0.5, swaync-notification-window"
      ];
    };
  };
}
