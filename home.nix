{ inputs, config, pkgs, ... }:

let
  usrname = "tpl";
in
{
  # 注意修改这里的用户名与用户目录
  home.username = usrname;
  home.homeDirectory = "/home/${usrname}";

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
  home.file.".config/waybar" = {
    source = ./programs/waybar;
    recursive = true;
  };

  home.file.".config/wofi" = {
    source = ./programs/wofi;
    recursive = true;
  };

  home.file.".config/btop" = {
    source = ./programs/btop;
    recursive = true;
  };

  # home.file.".config/dunst" = {
    # source = ./programs/dunst;
    # recursive = true;
  # };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs;[
    (wechat-uos.override {
      uosLicense = pkgs.fetchurl {
        url = "https://aur.archlinux.org/cgit/aur.git/plain/license.tar.gz?h=wechat-uos-bwrap";
        hash = "sha256-U3YAecGltY8vo9Xv/h7TUjlZCyiIQdgSIp705VstvWk=";
      };
    })

    bun
    dart-sass
    fd
    
    google-chrome
    cmatrix
    gedit
    rustup
    xarchiver
  
    neofetch

    tree

    nix-output-monitor

    btop  # replacement of htop/nmon
    qimgv

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

    platformTheme = "gtk";

    style.name = "adwaita-dark";

    style.package = pkgs.adwaita-qt;
  };

  gtk = {
    enable = true;

    # cursorTheme = {
      # package = pkgs.bibata-cursors;
      # name = "Bibata-Modern-Ice";
    # };

    theme = {
      # name = "Adwaita-dark";
      # package = pkgs.gnome.gnome-themes-extra;
      name = "Catppuccin-Macchiato-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        tweaks = [ "rimless" ];
        variant = "macchiato";
      };
    };

    iconTheme = {
     package = pkgs.colloid-icon-theme;
     name = "Colloid-dark";
    };
  };

   programs.ags = {
    enable = true;

    # null or path, leave as null if you don't want hm to manage the config
    configDir = null;

    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
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
    bashrcExtra = ''
      export GTK_IM_MODULE=fcitx
      export QT_IM_MODULE=fcitx
    '';
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
        "inherits" = "catppuccin_frappe";
        "ui.background" = { };
      };
    };
  };

  # programs.eww = {
  #   enable = true;
  #   package = pkgs.eww-wayland;
  #   configDir = ./programs/eww;
  # };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      fade-in = 0.5;
      clock = true;
      effect-blur = "7x5";
      image = "${./wallpaper.jpg}";

      indicator-radius = 150;
      indicator-thickness = 10;

      inside-color = "000000";
      inside-clear-color = "000000";
      inside-caps-lock-color = "000000";
      inside-ver-color = "000000";
      inside-wrong-color = "ee2e2400";

      ring-color = "ffffff";
      ring-clear-color = "231f20";
      ring-caps-lock-color = "6d91ad";
      ring-ver-color = "231f20";
      ring-wrong-color = "231f20";

      text-color = "92dee0";
      text-clear-color = "92dee0";
      text-ver-color = "92dee0";
      text-wrong-color = "ff0000";
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.nerdfonts;
      name = "Hack";
      size = 15;
    };
    settings = {
      window_padding_width = "15";  
      background_opacity = "0.7";
      font_size = "13.0";
      cursor_shape = "beam";
      touch_scroll_multiplier = "7.0";

      foreground              = "#CAD3F5";
      background              = "#24273A";
      selection_foreground    = "#24273A";
      selection_background    = "#F4DBD6";
      
      cursor                  = "#F4DBD6";
      cursor_text_color       = "#24273A";
      
      url_color               = "#F4DBD6";
      
      active_border_color     = "#B7BDF8";
      inactive_border_color   = "#6E738D";
      bell_border_color       = "#EED49F";
      
      wayland_titlebar_color  = "#24273A";
      macos_titlebar_color    = "#24273A";
      
      active_tab_foreground   = "#181926";
      active_tab_background   = "#C6A0F6";
      inactive_tab_foreground = "#CAD3F5";
      inactive_tab_background = "#1E2030";
      tab_bar_background      = "#181926";
      
      mark1_foreground = "#24273A";
      mark1_background = "#B7BDF8";
      mark2_foreground = "#24273A";
      mark2_background = "#C6A0F6";
      mark3_foreground = "#24273A";
      mark3_background = "#7DC4E4";
      
      color0 = "#494D64";
      color8 = "#5B6078";
      
      color1 = "#ED8796";
      color9 = "#ED8796";
      
      color2  = "#A6DA95";
      color10 = "#A6DA95";
      
      color3  = "#EED49F";
      color11 = "#EED49F";
      
      color4  = "#8AADF4";
      color12 = "#8AADF4";
      
      color5  = "#F5BDE6";
      color13 = "#F5BDE6";
      
      color6  = "#8BD5CA";
      color14 = "#8BD5CA";
      
      color7  = "#B8C0E0";
      color15 = "#A5ADCB";
    };
          
    keybindings = {
      "alt+n" = "new_tab";
      "alt+q" = "close_tab";
      "alt+k" = "next_tab";
      "alt+j" = "previous_tab";    
    };
  };
  
  imports = [
    ./programs/hyprland.nix
    ./programs/wlogout/wlogout.nix
    ./programs/vsc.nix
    ./programs/dunst.nix
    ./programs/omposh/omposh.nix
    inputs.ags.homeManagerModules.default
  ];
    
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
