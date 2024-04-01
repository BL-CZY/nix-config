rm -r /home/tpl/.config/kitty
rm -r /home/tpl/.config/waybar
rm -r /home/tpl/.config/wofi
rm -r /home/tpl/.config/dunst

sudo nixos-rebuild switch --flake .
