{ lib, config, pkgs, host, vars, ... }:
{
   stylix.enable = true;

   stylix.polarity = "dark";

   stylix.image = ./wall.png;

   stylix.base16Scheme = {
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

  stylix.fonts = {
    serif = config.stylix.fonts.monospace;
    sansSerif = config.stylix.fonts.monospace;
    emoji = config.stylix.fonts.monospace;

    monospace = {
      package = pkgs.nerd-fonts.fira-mono;
      name = "FiraMono Nerd Font";
    };

    sizes = {
      applications = 10;
      desktop = 12;
      popups = 10;
      terminal = 12;
    };
  };

  stylix.cursor = {
    size = 16;
  };

  stylix.opacity = {
   terminal  = 0.5;
  };

  stylix.targets = {
    console.enable = true;
    grub.enable = true; 
    gtk.enable = true;
    nixos-icons.enable = true;

    plymouth = {
      enable = true;
      logo = ./boot.jpg;
      logoAnimated = false;
    };
  };

  home-manager.users.${vars.user} = {
    stylix.targets = {
       feh.enable = true;
       tmux.enable = false;
    };
  };
}
