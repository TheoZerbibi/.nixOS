#!/bin/bash
WALLPAPER_DIR="$HOME/wallpapers/walls"

hex_to_rgba() {
    hex="$1"
    alpha="$2"
    r=$(printf '%d' 0x${hex:1:2})
    g=$(printf '%d' 0x${hex:3:2})
    b=$(printf '%d' 0x${hex:5:2})
    echo "rgba(${r}, ${g}, ${b}, ${alpha})"
}

menu() {
    find "${WALLPAPER_DIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | awk '{print "img:"$0}'
}

main() {
    choice=$(menu | wofi -c ~/.config/wofi/config -s ~/.config/wofi/style.css --show dmenu --prompt "Select Wallpaper:" -n)
    selected_wallpaper=$(echo "$choice" | sed 's/^img://')

    if [[ -z "$selected_wallpaper" ]]; then
        echo "No wallpaper selected."
        exit 1
    fi

    swww img "$selected_wallpaper" --transition-type any --transition-fps 60 --transition-duration 2 || {
        echo "Error: swww failed. Ensure it is installed and running."
        exit 1
    }

    wal -i "$selected_wallpaper" -n || {
        echo "Error: pywal failed. Ensure it is installed."
        exit 1
    }

    if [[ -f ~/.cache/wal/colors-kitty.conf ]]; then
        cp ~/.cache/wal/colors-kitty.conf ~/.config/kitty/current-theme.conf
    else
        echo "Warning: colors-kitty.conf not found."
    fi

    if command -v pywalfox &> /dev/null; then
        pywalfox update
    else
        echo "Warning: pywalfox is not installed."
    fi

    # if [[ -f ~/.config/cava/config ]]; then
    #     color1=$(awk 'match($0, /color2=\47(.*)\47/,a) { print a[1] }' ~/.cache/wal/colors.sh)
    #     color2=$(awk 'match($0, /color3=\47(.*)\47/,a) { print a[1] }' ~/.cache/wal/colors.sh)
    #     sed -i "s/^gradient_color_1 = .*/gradient_color_1 = '$color1'/" ~/.config/cava/config
    #     sed -i "s/^gradient_color_2 = .*/gradient_color_2 = '$color2'/" ~/.config/cava/config
    #     pkill -USR2 cava || cava -p ~/.config/cava/config
    # else
    #     echo "Warning: Cava config not found."
    # fi

    source ~/.cache/wal/colors.sh || {
        echo "Error: Failed to source colors.sh."
        exit 1
    }

    background_rgba=$(hex_to_rgba "#131b1e" 0.5)
    color7_rgba=$(hex_to_rgba "#d1e0cb" 0.5)
    color9_rgba=$(hex_to_rgba "#669165" 0.5)

    cat <<EOF > ~/.cache/wal/colors-waybar.css
:root {
    --color0: ${color0};
    --color1: ${color1};
    --color4: ${color4};
    --color5: ${color5};
    --color7: ${color7};
    --color9: ${color9};
    --background: ${background};
    --background-rgba: $background_rgba;
    --color7-rgba: $color7_rgba;
    --color9-rgba: $color9_rgba;
}
EOF

    ln -sf ~/.cache/wal/colors-waybar.css ~/.cache/wal/colors-hyprland
}

main
