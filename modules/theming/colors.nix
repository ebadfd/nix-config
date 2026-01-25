{
  scheme = {
    mango = {
      name = "Mango";
      base16 = {
        base00 = "0d0f0f"; # background
        base01 = "161a19"; # lighter bg
        base02 = "1e2625"; # selection bg
        base03 = "5a6a5a"; # comments
        base04 = "8a9a8a"; # dark fg
        base05 = "b0c0b0"; # default fg (brighter)
        base06 = "c5d5c5"; # light fg
        base07 = "daeada"; # lightest fg
        base08 = "c07070"; # red - errors, deleted
        base09 = "d4a067"; # orange - numbers, constants
        base0A = "b5c06a"; # yellow - classes, search
        base0B = "7fb080"; # green - strings, success
        base0C = "6aacac"; # cyan - regex, escape chars
        base0D = "70a0b0"; # blue - functions, methods
        base0E = "a08aad"; # purple - keywords
        base0F = "c08070"; # brown - deprecated
      };
      hex = {
        bg = "#0d0f0f";
        bg1 = "#161a19";
        bg2 = "#1e2625";
        fg = "#b0c0b0";
        fg1 = "#c5d5c5";
        fg2 = "#daeada";
        comment = "#5a6a5a";
        accent = "#6aacac";
        red = "#c07070";
        orange = "#d4a067";
        yellow = "#b5c06a";
        green = "#7fb080";
        cyan = "#6aacac";
        blue = "#70a0b0";
        purple = "#a08aad";
        brown = "#c08070";
      };
    };

    cozy-bear = {
      name = "Cozy Bear";
      base16 = {
        base00 = "181b23";
        base01 = "2a2f3a";
        base02 = "3c3836";
        base03 = "665c54";
        base04 = "d3c8ba";
        base05 = "eae3d9";
        base06 = "f3eee5";
        base07 = "f3eee5";
        base08 = "d36c6c";
        base09 = "e7a953";
        base0A = "f6c982";
        base0B = "a8c074";
        base0C = "78b6bc";
        base0D = "4d8dc4";
        base0E = "b18bbb";
        base0F = "d65d0e";
      };
      hex = {
        bg = "#181b23";
        bg1 = "#2a2f3a";
        bg2 = "#3c3836";
        fg = "#eae3d9";
        fg1 = "#f3eee5";
        fg2 = "#f3eee5";
        comment = "#665c54";
        accent = "#78b6bc";
        red = "#d36c6c";
        orange = "#e7a953";
        yellow = "#f6c982";
        green = "#a8c074";
        cyan = "#78b6bc";
        blue = "#4d8dc4";
        purple = "#b18bbb";
        brown = "#d65d0e";
      };
    };
  };

  active = "mango";
}
