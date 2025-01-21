{
  nixpkgs,
  pkgs,
  ...
}: {
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
      serif = ["EB Garamond" "Noto Serif"];
      monospace = ["Berkeley Mono Variable" "Noto Sans Mono"];
      emoji = ["Noto Color Emoji"];
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
      };
      master.mfact = 0.66;
      group.auto_group = false;
      input.follow_mouse = 2;

      general = {
        border_size = 2;
        gaps_in = 8;
        gaps_out = 16;
        "col.inactive_border" = "$base";
        "col.active_border" = "$teal";
      };
      group = {
        "col.border_inactive" = "$base";
        "col.border_active" = "$teal";
      };
      group.groupbar = {
        enabled = true;
        font_size = 12;
        height = 24;
        text_color = "$text";
        "col.active" = "$surface0";
        "col.inactive" = "$base";
      };
      misc.font_family = "Public Sans";

      bind = [
        "SUPER SHIFT, up, movewindoworgroup, u"
        "SUPER SHIFT, down, movewindoworgroup, d"
        "SUPER SHIFT, left, movewindoworgroup, l"
        "SUPER SHIFT, right, movewindoworgroup, r"

        "SUPER, up, movefocus, u"
        "SUPER, left, movefocus, l"
        "SUPER, down, movefocus, d"
        "SUPER, right, movefocus, r"

        "SUPER SHIFT, tab, togglegroup,"
        "SUPER, tab, changegroupactive, f"
        "SUPER, q, killactive,"

        "SUPER, t, exec, ghostty"
        "SUPER, e, exec, code"
        "SUPER, b, exec, firefox"
        "SUPER, r, exec, menu"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"

        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"

        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"
      ];

      exec-once = [
        "systemctl --user enable --now hyprpolkitagent.service"
        "waybar"
      ];
    };
  };

  programs.waybar = {
    enable = true;

    settings = [
      {
        layer = "top";
        position = "top";
        height = 32;

        modules-left = [
          "wireplumber"
        ];
        modules-center = [
          "hyprland/workspace"
          "hyprland/window"
        ];
        modules-right = [
          "network"
          "tray"
          "clock"
        ];

        network = {
          format-wifi = "{essid}";
          format-ethernet = "{ipaddr}/{cidr}";
          format-disconnected = "";

          tooltip-format-wifi = "{ifname} {ipaddr}/{cidr} {signalStrength}%";
          tooltip-format-ethernet = "{ifname}";
        };
        clock = {
          format = "{:%Y-%m-%d %H:%M}";
          tooltip-format = "{tz_list}";
          timezones = [
            "Europe/Paris"
          ];
        };

        style = ''
          * {
            font-family: Public Sans;
          }

          window#waybar {
            color: @text;
            background: @base;
          }

          .modules-right > .module {
            margin-right: 16px;
          }

          .modules-right > .module:last-child {
            margin-right: 0;
          }
        '';
      }
    ];
  };

  services.mako = {
    enable = true;
  };

  home.packages = with nixpkgs.stable; [
    hyprpolkitagent

    (pkgs.callPackage ../../modules/berkeley-mono.nix {})
    (google-fonts.override {
      fonts = [
        "EB Garamond"
      ];
    })
    public-sans
    noto-fonts
    noto-fonts-color-emoji
  ];
}