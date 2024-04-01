rm -rf /home/tpl/.config/kitty
rm -rf /home/tpl/.config/waybar
rm -rf /home/tpl/.config/wofi

sudo nixos-rebuild switch --flake .
