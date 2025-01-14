{ vars, ... }:
{
  home-manager.users.${vars.user} = {
    programs = {
      fastfetch = {
        enable = true;
        settings = {
          logo= {
            source= "nixos_old_small";
            padding= {
              top= 1;
            };
          };
          display= {
            separator= " ";
          };
          modules = [
            "break"
            {
              type = "title";
              format = "";
            }
            "break"
            {
              type = "os";
              key = "   ";
              format = " {2}";
            }
            {
              type =  "kernel";
              key =  "    ";
              format = "{2}";
            }
            {
              type =  "memory";
              key =  "  󰍛  ";
              format =  "{1} / {2} ({3})";
            }
            {
              type =  "packages";
              key =  "  󰏗  ";
              format =  "{5} (rpm), {1} (all)";
            }
            {
              type =  "uptime";
              key =  "    ";
              format =  "{2} hours, {3} mins";
            }
            "break"
            {
              type =  "colors";
              key =  "     ";
              symbol =  "circle";
            }
          ];
        };
      };
    };
  };
}
