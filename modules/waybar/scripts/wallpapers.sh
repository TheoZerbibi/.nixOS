#!/bin/bash
WALLPAPER_DIR="$HOME/wallpapers/walls"
menu() {
    find "${WALLPAPER_DIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | awk '{print "img:"$0}'
}
main() {
    choice=$(menu | wofi -c ~/.config/wofi/config -s ~/.config/wofi/style.css --show dmenu --prompt "Select Wallpaper:" -n)
    selected_wallpaper=$(echo "$choice" | sed 's/^img://')
    swww img "$selected_wallpaper" --transition-type any --transition-fps 60 --transition-duration 2
    wal -i "$selected_wallpaper" -n --cols16
    swaync-client --reload-css
    cat ~/.cache/wal/colors-kitty.conf > ~/.config/kitty/current-theme.conf
    pywalfox update
    color1=$(awk 'match($0, /color2=\47(.*)\47/,a) { print a[1] }' ~/.cache/wal/colors.sh)
    color2=$(awk 'match($0, /color3=\47(.*)\47/,a) { print a[1] }' ~/.cache/wal/colors.sh)
    cava_config="$HOME/.config/cava/config"
    sed -i "s/^gradient_color_1 = .*/gradient_color_1 = '$color1'/" $cava_config
    sed -i "s/^gradient_color_2 = .*/gradient_color_2 = '$color2'/" $cava_config
    pkill -USR2 cava || cava -p $cava_config
    source ~/.cache/wal/colors.sh && cp -r $wallpaper ~/wallpapers/pywallpaper.jpg 
    
    ln -sf ~/.cache/wal/colors-waybar.css ~/.cache/wal/colors-hyprland

    echo ":root {" > ~/.cache/wal/colors-waybar.css
    echo "    --color0: ${color0};" >> ~/.cache/wal/colors-waybar.css
    echo "    --color1: ${color1};" >> ~/.cache/wal/colors-waybar.css
    echo "    --color4: ${color4};" >> ~/.cache/wal/colors-waybar.css
    echo "    --color5: ${color5};" >> ~/.cache/wal/colors-waybar.css
    echo "    --color7: ${color7};" >> ~/.cache/wal/colors-waybar.css
    echo "    --color9: ${color9};" >> ~/.cache/wal/colors-waybar.css
    echo "    --background: ${background};" >> ~/.cache/wal/colors-waybar.css
    echo "}" >> ~/.cache/wal/colors-waybar.css
}
main
