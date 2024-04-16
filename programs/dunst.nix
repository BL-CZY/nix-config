{ pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {  
        monitor = 0;
        follow = "mouse";
        width = 350;
        height = 100;
        origin = "top-right";
        offset = "20x20";
        corner_radius = 0;
        scale = 0;
        notification_limit = 0;
        progress_bar = true;
        progress_bar_height = 100;
        progress_bar_frame_width = 2;
        progress_bar_min_width = 350;
        progress_bar_max_width = 350;
        indicate_hidden = "yes";
        transparency = 0;
        separator_height = 2;
        padding = 15;
        horizontal_padding = 15;
        text_icon_padding = 0;
        frame_width = 2;
        gap_size = 0;
        separator_color = "frame";
        sort = "yes";
        idle_threshold = 120;
        font = "JetBrains Mono 12";
        line_height = 2;
        markup = "full";
        format = "%s\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";
        enable_recursive_icon_lookup = true;
        icon_position = "left";
        min_icon_size = 24;
        max_icon_size = 48;
        sticky_history = "yes";
        history_length = 20;
        browser = "/usr/bin/xdg-open";
        always_run_script = true;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
        title = "Dunst";
        class = "Dunst";
      };

      urgency_low = {
        timeout = 2;
        background = "#24273a";
        foreground = "#cad3f5";
        frame_color = "#8aadf4";
      };

      
      urgency_normal = {
        timeout = 5;
        background = "#24273a";
        foreground = "#cad3f5";
        frame_color = "#8aadf4";
      };
      
      gency_critical = {
        timeout = 0;
        background = "#24273a";
        foreground = "#ed8796";
        frame_color = "#ed8796";
      };
    };
  };
}
