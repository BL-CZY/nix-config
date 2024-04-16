nix shell nixpkgs#nix-prefetch-git --extra-experimental-features nix-command --extra-experimental-features flakes
nix-prefetch-git https://github.com/Kangie/sddm-sugar-candy.git
nix-prefetch-url sha256 license.tar.gz
