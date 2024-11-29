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
        };
      };
    };
  };
}

