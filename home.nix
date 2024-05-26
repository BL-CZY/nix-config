{ inputs, config, pkgs, ... }:

let
  usrname = "tpl";
in
{
  home.username = usrname;
  home.homeDirectory = "/home/${usrname}";

  home.file = {
    ".config/rofi/config.rasi" = {
      source = ./programs/config.rasi;
      recursive = true;
    };
  
    ".config/hypr/hyprlock.conf" = {
      source = ./programs/hyprlock.conf;
      recursive = true;
    };

    ".config/waybar" = {
      source = ./programs/waybar;
      recursive = true;
    };

    ".config/btop" = {
      source = ./programs/btop;
      recursive = true;
    };

    ".config/swappy" = {
      source = ./programs/swappy;
      recursive = true;
    };

    ".config/fcitx5" = {
      source = ./programs/fcitx5/fcitx5;
      recursive = true;
    };

    ".local/share/fcitx5/themes/catppuccin-macchiato" = {
      source = ./programs/fcitx5/catppuccin-macchiato;
      recursive = true;
    };
  };
  
  fonts.fontconfig.enable = true;

  home.packages = with pkgs;[
    (wechat-uos.override {
      uosLicense = pkgs.fetchurl {
        url = "https://aur.archlinux.org/cgit/aur.git/plain/license.tar.gz?h=wechat-uos-bwrap";
        hash = "sha256-U3YAecGltY8vo9Xv/h7TUjlZCyiIQdgSIp705VstvWk=";
      };
    })
    (rofi.override { plugins = [ pkgs.rofi-emoji ]; })
    aseprite
    qalculate-gtk
    gnome.file-roller
    libinput
    swappy
    gamescope
    godot_4
    
    google-chrome
    cmatrix
    gedit
    rustup
  
    neofetch

    tree
    nnn

    nix-output-monitor

    btop  # replacement of htop/nmon
    qimgv
    hyprlock
    (pkgs.nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  services.fusuma = {
    enable = true;
    package = pkgs.fusuma;
    settings = {
      threshold = {
        swipe = 0.1;
        pinch = 0.5;
        hold = 0.0;
      };
      interval = {
        swipe = 0.7;
      };
      swipe = {
        "4" = {
          "left" = {
            command = "hyprctl dispatch togglespecialworkspace magic";
          };
          "right" = {
            command = "hyprctl dispatch togglespecialworkspace magic";
          };
        };
      };
      pinch = {
        "3" = {
          "out" = {
            command = "hyprctl dispatch fullscreen 0";
          };
          "in" = {
            command = "hyprctl dispatch fullscreen 0";
          };
        };
      };

      hold = {
        "4" = {
          command = "echo \"3 hold\"";
        };
      };
    };
  };

  qt = {
    enable = true;

    platformTheme = "gtk3";

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
      export EDITOR=hx
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
      image = "${./programs/wallpaper.jpg}";

      indicator-radius = 150;
      indicator-thickness = 10;

      inside-color = "#24273a";
      inside-clear-color = "#24273a";
      inside-caps-lock-color = "#24273a";
      inside-ver-color = "#24273a";
      inside-wrong-color = "#ed8796";

      ring-color = "#8aadf4";
      ring-clear-color = "#8aadf4";
      ring-caps-lock-color = "#8aadf4";
      ring-ver-color = "#8aadf4";
      ring-wrong-color = "#ee99a0";

      text-color = "#cad3f5";
      text-clear-color = "#cad3f5";
      text-ver-color = "#cad3f5";
      text-wrong-color = "#cad3f5";

      key-hl-color = "#a6da95";
      bs-hl-color = "#ed8796";
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
      window_padding_width = "20";  
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

  programs.eww = {
    enable = true;
    package = pkgs.eww;
    configDir = ./programs/eww;
  };
  
  imports = [
    ./programs/hyprland.nix
    ./programs/wlogout/wlogout.nix
    ./programs/vsc.nix
    ./programs/dunst.nix
    ./programs/starship/starship.nix
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
