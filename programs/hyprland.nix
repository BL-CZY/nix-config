{ pkgs, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.networkmanagerapplet}/bin/nm-applet &
    ${checkVolume}/bin/checkVol &
    ${checkBrightness}/bin/checkBri &
    eww daemon &
    fcitx5 &
    ${pkgs.fusuma}/bin/fusuma &
  '';

  checkVolume = pkgs.pkgs.writeShellScriptBin "checkVol" ''    
    while [ true ]; do
        case $(eww get countdown) in
            "3")
                eww update countdown="2"
            ;;
    
            "2")
                eww update countdown="1"
            ;;
    
            "1")
                eww update countdown="0"
                eww close popup_vol
            ;;
        esac
        sleep 1
    done
  '';

  checkBrightness = pkgs.pkgs.writeShellScriptBin "checkBri" ''    
      while [ true ]; do
          case $(eww get countdownbri) in
              "3")
                  eww update countdownbri="2"
              ;;
      
              "2")
                  eww update countdownbri="1"
              ;;
      
              "1")
                  eww update countdownbri="0"
                  eww close popup_bri
              ;;
          esac
          sleep 1
      done
    '';

  screenShotScript = pkgs.pkgs.writeShellScriptBin "screenShot" ''
    # output="$HOME/Pictures/ScreenShots"/"$(date +%Y%m%d-%H%M%S)".png
    # grim -g "$(slurp)" $output
    # qimgv $output
    grim -g "$(slurp)" - | swappy -f -
  '';

  syncVolume = pkgs.pkgs.writeShellScriptBin "syncVol" ''    
    if [ $(eww get countdown) == "0" ]; then
        eww open popup_vol
    fi
    eww update countdown=2

    current_volume=0.00
    
    #get the result
    output=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    
    #parse the current volume
    current_volume=$(echo "$output" | grep -oE '[+-]?[0-9]+([.][0-9]+)?')
    
    echo $current_volume
    
    #if it's 1.00, set it to 100
    if [ $(echo $current_volume) == "1.00" ]; then
      final="100"
    else
      # Check if the first character is not 0
      if [[ "$current_volume" =~ ^[1-9] ]]; then
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 100%
        final="100"
      else
        final=$(echo $current_volume | cut -d'.' -f2 | cut -c1-2)
      fi
    fi
    
    eww update current_volume=$final
  '';

  
  syncBrightness = pkgs.pkgs.writeShellScriptBin "syncBri" ''

    if [ $(eww get countdownbri) == "0" ]; then
        eww open popup_bri
    fi
    eww update countdownbri=2

    current_brightness=0.00
    
    # Specify the device name
    device="intel_backlight"
    
    # Get the current brightness and maximum brightness
    current_brightness=$(brightnessctl -d $device g)
    max_brightness=$(brightnessctl -d $device m)
    
    # Calculate the percentage
    percentage=$((current_brightness * 100 / max_brightness))
     
    eww update current_brightness=$percentage
  '';in
{
  wayland.windowManager.hyprland = {
    enable = true;
    
    settings = {

      # env = [
        # "GTK4_RC_FILES,/home/USER/.config/gtk-4.0/gtkrc"
        # "QT_QPA_PLATFORMTHEME,gtk4"
        # "QT_STYLE_OVERRIDE,gtk4"
      # ];

      monitor = ",1920x1080,auto,1"; 
      input = {
        kb_layout = "us";
 
        follow_mouse = 1;
 
        touchpad = {
          natural_scroll = 1;
          scroll_factor = 0.2;
          disable_while_typing = false;
        };
 
        sensitivity = "0";
      };
 
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(8AADF4FF)";
        "col.inactive_border" = "rgba(363a4fff)";
 
        layout = "dwindle";
 
        allow_tearing = false;
        resize_on_border = true;
        # no_border_on_floating = true;
      };
 
      decoration = {
        rounding = 10;
 
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
        };
 
        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";

        active_opacity = 1;
        inactive_opacity = 1;
      };
 
      animations = {
        enabled = "yes";
 
        "bezier" = "myBezier, 0.05, 0.9, 0.1, 1.05";
 
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "fadeLayers, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };    
 
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };
 
      master = {
        new_is_master = true;
      };
 
      gestures = {
        workspace_swipe = "on";
        workspace_swipe_cancel_ratio = 0.15;
      };
 
      misc = {
        force_default_wallpaper = 0;
      };

      device = {
          name = "epic-mouse-v1";
          sensitivity = "-0.5";
      };
              
      "$mainMod" = "SUPER";
 
      bind = [      
        "$mainMod, Q, exec, kitty"
        "$mainMod, F, exec, firefox"        
        "$mainMod, E, exec, thunar"
        "$mainMod, A, exec, rofi -show drun"
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, W, togglefloating"
        "$mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mainMod, P, pseudo,"
        "$mainMod, O, togglesplit,"
        "$mainMod SHIFT, L, exec, wlogout -m 300 -c 0"
        "$mainMod SHIFT, F, fullscreen"
 
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"
 
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
 
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
 
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, I, movetoworkspace, special:magic"
 
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        ''$mainMod SHIFT, S, exec, ${screenShotScript}/bin/screenShot''

        "$mainMod SHIFT, O, exec, ibus engine xkb:us::eng"
        "$mainMod SHIFT, P, exec, ibus engine libpinyin"

        "$mainMod CTRL, L, movewindow, r"
        "$mainMod CTRL, H, movewindow, l"
        "$mainMod CTRL, K, movewindow, u"
        "$mainMod CTRL, J, movewindow, d"

        # to switch between windows in a floating workspace
        "ALT,Tab,cyclenext," # change focus to another window
        "ALT,Tab,bringactivetotop," # bring it to the top
      ];
 
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+; ${syncVolume}/bin/syncVol"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-; ${syncVolume}/bin/syncVol"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-; ${syncBrightness}/bin/syncBri"
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%; ${syncBrightness}/bin/syncBri"
      ];

      windowrule = [
        "float, ^(qemu)$"
        "center, ^(qemu)$"
        "minsize 860 540, ^(qemu)$"

        "float, ^(kitty)$"
        "size 960 640, ^(kitty)$"
        "center, ^(kitty)$"

        "float, ^(Thunar)$"
        "minsize 960 640, ^(Thunar)$"
        "center, ^(Thunar)$"

        "float, ^(thunar)$"
        "center, ^(thunar)$"
        "minsize 960 640, ^(thunar)$"

        "float, ^(qimgv)$"
        "center, ^(qimgv)$"
                
        "float, ^(gedit)$"
        "center, ^(gedit)$"

        "float, ^(vlc)$"
        "center, ^(vlc)$"
      ];

      exec-once = [
        ''${startupScript}/bin/start''
        "wl-paste --type text --watch cliphist store #Stores only text data"
        "wl-paste --type image --watch cliphist store #Stores only image data"
        "dotoold"
      ];
    };
  };
}
