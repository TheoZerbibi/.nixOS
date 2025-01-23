{ lib, pkgs, ... }:
{
  imports = [
    ./hyprland-binds.nix
    ./hyprland-win-config.nix
    ./hypridle.nix
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
      sansSerif = ["Public Sans" "Noto Sans" "DejaVu Sans"];
      serif = ["EB Garamond" "Noto Serif" "DejaVu Serif"];
      monospace = ["Berkeley Mono Variable" "Noto Sans Mono" "DejaVu Sans Mono"];
      emoji = ["Noto Color Emoji" "Twemoji" "Symbola"];
    };
  };

  home.file = lib.mkMerge [
    {
      ".config/waybar/config.jsonc".source = ../modules/waybar/config.jsonc;
      ".config/waybar/style.css".source = ../modules/waybar/style.css;
    }
    {
      ".config/waybar/scripts/colorpicker.sh".source = ../modules/waybar/scripts/colorpicker.sh;
      ".config/waybar/scripts/wallpapers.sh".source = ../modules/waybar/scripts/wallpapers.sh;
    }
    {
      ".config/wofi/config".source = ../modules/wofi/config;
      ".config/wofi/style.css".source = ../modules/wofi/style.css;
    }
  ];

  programs.waybar.enable = true;
  services.mako.enable = true;

  home.packages = with pkgs; [
    hyprpolkitagent
    hypridle
    (callPackage ../../modules/berkeley-mono.nix {})
    (google-fonts.override {
      fonts = [ "EB Garamond" ];
    })
    public-sans
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-emoji
    font-awesome
    material-design-icons
  ];
}
