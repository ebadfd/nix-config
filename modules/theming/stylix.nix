{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
lib.mkMerge [
  {
    stylix.enable = true;

    stylix.polarity = "dark";
    stylix.image = ./wall.jpg;

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
      serif = {
        package = pkgs.eb-garamond;
        name = "EB Garamond";
      };
      sansSerif = {
        package = pkgs.overpass;
        name = "Overpass";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      monospace = {
        package = pkgs.nerd-fonts.fira-mono;
        name = "FiraMono Nerd Font";
        # package = pkgs.nerd-fonts.space-mono;
        # name = "SpaceMono Nerd Font";
      };

      sizes = {
        applications = 10;
        desktop = 12;
        popups = 10;
        terminal = if pkgs.stdenv.isLinux then 12 else 14;
      };
    };

    stylix.opacity = {
      terminal = 0.8;
    };

    home-manager.users.${vars.user} = {
      stylix.targets = {
        emacs.enable = false;
        feh.enable = true;
        tmux.enable = false;
      };
    };
  }
  (
    if pkgs.stdenv.isLinux then
      {
        stylix.cursor = {
          name = "Vanilla-DMZ";
          package = pkgs.vanilla-dmz;
          size = 16;
        };

        stylix.targets = {
          console.enable = true;
          grub.enable = true;
          gtk.enable = true;
          nixos-icons.enable = true;
          plymouth = {
            enable = false;
          };
        };
      }
    else
      { }
  )
]
