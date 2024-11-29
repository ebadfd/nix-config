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
              family = "Fira Mono";
              style = "Bold";
            };

            glyph_offset = {
              x = 0;
              y = 0;
            };

            italic = {
              family = "Fira Mono";
              style = "Italic";
            };

            normal = {
              family = "Fira Mono";
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

