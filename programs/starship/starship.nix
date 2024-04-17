{ pkgs, ... }:

let
  flavour = "macchiato"; # One of `latte`, `frappe`, `macchiato`, or `mocha`
in
{
  programs.starship = {
    enable = true;
    package = pkgs.starship;
    enableBashIntegration = true;
    settings = {
      palette = "catppuccin_${flavour}";
    } // builtins.fromTOML (builtins.readFile ./starship.toml);
  };
}
