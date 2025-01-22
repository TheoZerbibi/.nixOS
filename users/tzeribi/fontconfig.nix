{ lib, ... }: {
  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      sansSerif = [
        "Public Sans"
        "Noto Sans"
        "DejaVu Sans"
      ];
      serif = [
        "EB Garamond"
        "Noto Serif"
        "DejaVu Serif"
      ];
      monospace = [
        "Berkeley Mono Variable"
        "Noto Sans Mono"
        "DejaVu Sans Mono"
      ];
      emoji = [
        "Noto Color Emoji"
        "Twemoji"
        "Symbola"
      ];
    };

    extraConfig = ''
      <?xml version='1.0'?>
      <!DOCTYPE fontconfig SYSTEM 'urn:fontconfig:fonts.dtd'>
      <fontconfig>
        <!-- Active l'antialiasing -->
        <match target="font">
          <edit name="antialias" mode="assign">
            <bool>true</bool>
          </edit>
        </match>

        <!-- Active le hinting léger -->
        <match target="font">
          <edit name="hintstyle" mode="assign">
            <const>hintslight</const>
          </edit>
        </match>

        <!-- Définit le rendu en subpixel (LCD) -->
        <match target="font">
          <edit name="rgba" mode="assign">
            <const>rgb</const>
          </edit>
        </match>
      </fontconfig>
    '';
  };
}
