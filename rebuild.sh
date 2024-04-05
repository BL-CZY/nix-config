rm -r /home/tpl/.config/waybar
rm -r /home/tpl/.config/wofi

sudo nixos-rebuild switch --flake .
