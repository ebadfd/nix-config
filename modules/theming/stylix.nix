{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
let
  colors = import ./colors.nix;
  activeScheme = colors.scheme.${colors.active};
in
lib.mkMerge [
  {
    stylix.enable = true;

    stylix.polarity = "dark";
    stylix.image = ../../wallpaper.png;

    stylix.base16Scheme = activeScheme.base16;

    stylix.icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      light = "Papirus-Light";
      dark = "Papirus-Dark";
    };

    stylix.fonts = {
      serif = {
        package = pkgs.eb-garamond;
        name = "EB Garamond";
      };
      sansSerif = {
        package = pkgs.source-sans-pro;
        name = "Source Sans Pro";
        # package = pkgs.ibm-plex;
        # name = "IBM Plex Sans";
        # name = "Overpass";
        # "DejaVu Sans" "IPAPGothic"
        # name = "Inter";
        # name = "Overpass Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
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
        tmux.enable = true;
        nixvim.enable = true;
        waybar.enable = true;
        mako.enable = true;
        swaylock.enable = false;
        alacritty.enable = true;
        rofi.enable = true;
        firefox.profileNames = [
          "${vars.user}"
          "${vars.user}-work"
        ];
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
          qt = {
            enable = true;
          };
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
