{ lib, ... }:
{
  programs.hyprlock = {
    enable = true;

    settings = {
      source = "$HOME/.cache/wal/colors-hyprland";

      background = {
        monitor = "";
        path = "$wallpaper";
        blur_size = 7;
        blur_passes = 2;
        brightness = 0.4;
      };

      input-field = {
        monitor = "";
        size = "6%, 4%";
        outline_thickness = 0;
        dots_rounding = 4;
        dots_spacing = 0.5;
        dots_fade_time = 300;
        inner_color = "$backgroundCol";
        outer_color = "$backgroundCol $backgroundCol";
        check_color = "$backgroundCol $backgroundCol";
        fail_color = "$backgroundCol $backgroundCol";
        font_color = "$color9";
        font_family = "CodeNewRoman Nerd Font Propo";
        fade_on_empty = false;
        shadow_color = "rgba(0,0,0,0.5)";
        shadow_passes = 1;
        shadow_size = 5;
        rounding = 20;
        placeholder_text = "<i></i>";
        fail_text = "<b>FAIL</b>";
        fail_timeout = 300;
        position = "0, -100";
        halign = "center";
        valign = "center";
      };

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] date +\"<b>%I</b>\"";
          color = "$color9";
          font_size = 200;
          font_family = "CodeNewRoman Nerd Font Propo";
          shadow_passes = 0;
          shadow_size = 5;
          position = "-120, 410";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] date +\"<b>%M</b>\"";
          color = "rgba(150,150,150,0.4)";
          font_size = 200;
          font_family = "CodeNewRoman Nerd Font Propo";
          shadow_passes = 0;
          shadow_size = 5;
          position = "120, 230";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] date +\"<b>%A, %B %d, %Y</b>\"";
          color = "$color4";
          font_size = 40;
          font_family = "CodeNewRoman Nerd Font Propo";
          shadow_passes = 0;
          shadow_size = 4;
          position = "-40,-20";
          halign = "right";
          valign = "top";
        }
        {
          monitor = "";
          text = "<i>Hello</i> <b>$USER</b>";
          color = "$color5";
          font_size = 40;
          font_family = "CodeNewRoman Nerd Font Propo";
          shadow_passes = 0;
          shadow_size = 4;
          position = "40,-20";
          halign = "left";
          valign = "top";
        }
      ];
    };
  };
}
