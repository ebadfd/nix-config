{ config, lib, pkgs, vars, ... }:
{
  config = lib.mkIf (config.x11wm.enable) {
    home-manager.users.${vars.user} = {
      home.packages = [ pkgs.libnotify ];
      services.dunst = {
        enable = true;
        iconTheme = {
          name = "Papirus Dark";
          package = pkgs.papirus-icon-theme;
          size = "16x16";
        };
        settings = {
          global = {
            follow = "mouse";
            monitor = 0;
            width = 300;
            height = 200;
            origin = "top-right";
            offset = "50x50";
            shrink = "yes";
            transparency = 0;
            padding = 16;
            horizontal_padding = 16;
            frame_width = 3;
            line_height = 4;
            idle_threshold = 120;
            markup = "full";
            format = ''<b>%s </b>\n%b'';
            alignment = "left";
            vertical_alignment = "center";
            icon_position = "left";
            word_wrap = "yes";
            ignore_newline = "no";
            show_indicators = "yes";
            sort = true;
            stack_duplicates = true;
            # startup_notification = false;
            hide_duplicate_count = true;
          };
        };
      };
      xdg.dataFile."dbus-1/services/org.knopwob.dunst.service".source = "${pkgs.dunst}/share/dbus-1/services/org.knopwob.dunst.service";
    };
  };
}
