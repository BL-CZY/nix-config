{ pkgs, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &
    ${pkgs.networkmanagerapplet}/bin/nm-applet &
  
    sleep 1
  
    ${pkgs.swww}/bin/swww img ${./wallpaper.jpg} &

    sleep 1
    
    ${pkgs.ibus}/bin/ibus start &
  '';
in
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
        };
 
        sensitivity = "0";
      };
 
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(468284ee)";
        "col.inactive_border" = "rgba(595959aa)";
 
        layout = "dwindle";
 
        allow_tearing = false;
        resize_on_border = true;
        no_border_on_floating = true;
      };
 
      decoration = {
        rounding = 10;
 
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
 
        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";

        active_opacity = 0.9;
        inactive_opacity = 0.9;
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
      };
 
      misc = {
        force_default_wallpaper = 0;
      };
 
      "device:epic-mouse-v1" = {
        sensitivity = -0.5;
      };
 
      "$mainMod" = "SUPER";
 
      bind = [      
        "$mainMod, Q, exec, kitty"
        "$mainMod, F, exec, firefox"        
        "$mainMod, E, exec, thunar"
        "$mainMod, A, exec, wofi --show drun"
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, V, togglefloating"
        "$mainMod, P, pseudo,"
        "$mainMod, O, togglesplit,"
        "$mainMod SHIFT, L, exec, wlogout"
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

        ''$mainMod SHIFT, S, exec, grim -g "$(slurp)"''

        "$mainMod SHIFT, O, exec, ibus engine xkb:us::eng"
        "$mainMod SHIFT, P, exec, ibus engine libpinyin"

        # to switch between windows in a floating workspace
        "ALT,Tab,cyclenext," # change focus to another window
        "ALT,Tab,bringactivetotop," # bring it to the top
      ];
 
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
      ];

      windowrule = [
        "float, ^(qemu)$"
        "center, ^(qemu)$"
        "minsize 860 540, ^(qemu)$"

        "float, ^(Thunar)$"
        "minsize 960 640, ^(Thunar)$"

        "float, ^(thunar)$"
        "minsize 960 640, ^(thunar)$"

        "float, ^(qimgv)$"
                
        "float, ^(gedit)$"

        "float, ^(vlc)$"

        "nofocus, ^(Ibus-ui-gtk3)$"
        "center, ^(Ibus-ui-gtk3)$"
      ];

      exec-once = ''${startupScript}/bin/start'';
    };
  };
}
