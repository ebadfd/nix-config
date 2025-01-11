{ vars, ... }:

{
  home-manager.users.${vars.user} = {
    programs = {
      alacritty = {
        enable = true;

        settings = {
          env = {
            TERM = "xterm-256color";
            WINIT_X11_SCALE_FACTOR = "1.0";
          };

          font = {
            size = 12;

            bold = {
              family = "FiraMono Nerd Font";
              style = "Bold";
            };

            glyph_offset = {
              x = 0;
              y = 0;
            };

            italic = {
              family = "FiraMono Nerd Font";
              style = "Italic";
            };

            normal = {
              family = "FiraMono Nerd Font";
              style = "Regular";
            };

            offset = {
              x = 0;
              y = 0;
            };
          };

          scrolling = {
            history = 10000;
            multiplier = 3;
          };

          colors = {
            primary = {
              background = "#181b23";
              foreground = "#eae3d9";
            };

            cursor = {
              text = "#181b23";
              cursor = "#eae3d9";
            };

            normal = {
              black   = "#181b23";
              red     = "#d36c6c";
              green   = "#a8c074";
              yellow  = "#e7a953";
              blue    = "#4d8dc4";
              magenta = "#b18bbb";
              cyan    = "#78b6bc";
              white   = "#d3c8ba";
            };

            bright = {
              black   = "#2a2f3a";
              red     = "#e88383";
              green   = "#b8d084";
              yellow  = "#f6c982";
              blue    = "#73a8e6";
              magenta = "#c6a2d6";
              cyan    = "#8ccfd3";
              white   = "#f3eee5";
            };
          };
        };
      };
    };
  };
}
