{ vars, ... }:

{
  home-manager.users.${vars.user} = {
    programs = {
      alacritty = {
        enable = true;
        settings = {
          font = {
            normal.family = "Fira Mono";
            bold = { style = "Bold"; };
            size = 11;
          };
          offset = {
            x = -1;
            y = 0;
          };
        };
      };
    };
  };
}

