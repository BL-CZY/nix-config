{ pkgs,... }:
{
  programs.oh-my-posh = {
    enable = true;
    settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile "${./theme.json}"));
  };
}
