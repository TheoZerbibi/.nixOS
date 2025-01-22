{ lib, pkgs, ... }:
{
  imports = [
    ./hyprland-binds.nix
  ];

  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "teal";

    cursors.enable = true;
    gtk.enable = true;
    hyprland.enable = true;
    mako.enable = true;
    waybar.enable = true;
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = ["Public Sans" "Noto Sans"];
      serif     = ["EB Garamond" "Noto Serif"];
      monospace = ["Berkeley Mono Variable" "Noto Sans Mono"];
      emoji     = ["Noto Color Emoji"];
    };
  };

  xdg.configFile."fontconfig/fonts.conf".text = ''
    <?xml version='1.0'?>
    <!DOCTYPE fontconfig SYSTEM 'urn:fontconfig:fonts.dtd'>
    <fontconfig>
      <include ignore_missing="yes" prefix="xdg">fontconfig/conf.d</include>
    </fontconfig>
  '';

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      input = {
        kb_layout = "us";
        kb_options = "alt_shift_toggle";
        numlock_by_default = true;
      };

      general = {
        layout = "master";
        resize_on_border = true;
        border_size = 2;
        gaps_in = 8;
        gaps_out = 16;
        "col.inactive_border" = "$base";
        "col.active_border"   = "$teal";
      };

      master.mfact = 0.66;
      group.auto_group = false;
      input.follow_mouse = 2;

      group = {
        "col.border_inactive" = "$base";
        "col.border_active"   = "$teal";
      };

      group.groupbar = {
        enabled = true;
        font_size = 12;
        height = 24;
        text_color = "$text";
        "col.active"   = "$surface0";
        "col.inactive" = "$base";
      };
      misc.font_family = "Public Sans";

      exec-once = [
        "systemctl --user enable --now hyprpolkitagent.service"
        "waybar"
      ];

      layerrule = [
        "blur, waybar"
        "ignorezero, waybar"
        "ignorealpha 0.5, waybar"
      ];
    };
  };

  home.file.".xprofile".text = ''
    mkdir -p $HOME/.config/waybar/scripts
    if [ ! -f $HOME/.config/waybar/config.jsonc ]; then
      cp /etc/nixos/modules/waybar/config.jsonc $HOME/.config/waybar/
    fi
    if [ ! -f $HOME/.config/waybar/style.css ]; then
      cp /etc/nixos/modules/waybar/style.css $HOME/.config/waybar/
    fi
    for f in /etc/nixos/modules/waybar/scripts/*.{sh,js}; do
      base=$(basename "$f")
      if [ ! -f "$HOME/.config/waybar/scripts/$base" ]; then
        cp "$f" "$HOME/.config/waybar/scripts/$base"
        chmod +x "$HOME/.config/waybar/scripts/$base"
      fi
    done

    wal -i $HOME/.cache/wal/colors-waybar.css
  '';

  programs.waybar.enable = true;
  services.mako.enable = true;
  home.packages = with pkgs; [
    hyprpolkitagent
    (pkgs.callPackage ../../modules/berkeley-mono.nix {})
    (pkgs.google-fonts.override {
      fonts = [ "EB Garamond" ];
    })
    pkgs.public-sans
    pkgs.noto-fonts
    pkgs.noto-fonts-color-emoji
    pkgs.noto-fonts-emoji
    pkgs.nerd-fonts
    pkgs.font-awesome
    pkgs.material-design-icons
    noto-fonts-symbols
  ];
}
