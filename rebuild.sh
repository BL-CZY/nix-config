git add .
git commit -m "auto commit"
git push origin main
sudo nixos-rebuild switch --flake .
