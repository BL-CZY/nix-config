{ config, pkgs, ... }:

{
  # 注意修改这里的用户名与用户目录
  home.username = "tpl";
  home.homeDirectory = "/home/tpl";

  # 直接将当前文件夹的配置文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # 递归将某个文件夹中的文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # 递归整个文件夹
  #   executable = true;  # 将其中所有文件添加「执行」权限
  # };

  # 直接以 text 的方式，在 nix 配置文件中硬编码文件内容
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  home.file.".config/kitty" = {
    source = ./kitty;
    recursive = true;
  };

  home.file.".config/waybar" = {
    source = ./waybar;
    recursive = true;
  };

  home.file.".config/wofi" = {
    source = ./wofi;
    recursive = true;
  };

  home.file.".config/dunst" = {
    source = ./dunst;
    recursive = true;
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs;[
    neofetch

    # archives
    zip
    xz
    unzip
    p7zip

    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    tree

    nix-output-monitor

    btop  # replacement of htop/nmon

    (pkgs.nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  qt = {
    enable = true;

    # platformTheme = "gtk3";

    # style.name = "adwaita-dark";

    # style.package = pkgs.adwaita-qt;
  };

  gtk = {
    enable = true;

    # cursorTheme = {
      # package = pkgs.bibata-cursors;
      # name = "Bibata-Modern-Ice";
    # };

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };

    iconTheme = {
     # package = gruvboxPlus;
     name = "Qogir";
    };
  };

  # git 相关配置
  programs.git = {
    enable = true;
    userName = "BL-CZY";
    userEmail = "jiguangllsw@gmail.com";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.neovim = {
    enable = true;
    # plugins = with pkgs.vimPlugins; [
    #   {
    #     plugin = coc-rust-analyzer;
    #     config = ""
    #   }
    # ];
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "autumn_night_transparent";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
    languages.language = [{
      name = "nix";
    } {
      name = "rust";
    }];
    themes = {
      autumn_night_transparent = {
        "inherits" = "catppuccin_macchiato";
        # "ui.background" = { };
      };
    };
  };

  imports = [./hyprland.nix];
  
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
