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

          window = {
            padding = {
              x = 3;
              y = 3;
            };
          };

          font = {
            glyph_offset = {
              x = 0;
              y = 0;
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
