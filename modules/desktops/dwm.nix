{ config, lib, pkgs, vars, ... }:

with lib;
{
  options = {
    dwm = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.dwm.enable) {
    programs = {
      zsh.enable = true;
    };

    services.xserver = {
      enable = true;
      displayManager = {
        startx.enable = true;
      };
      windowManager.dwm = {
        enable = true;
        package = pkgs.dwm.overrideAttrs {
          src = pkgs.fetchFromGitHub {
            owner = "ebadfd";
            repo = "dwm";
            rev = "3f6cf3d0d511110fd4fba3c89722f289f15c89be";
            hash = "sha256-4Yc2XHND3uiClaC9SgoukbWEV/Y2/XzSABXtuylacV0=";
          };
        };
      };
    };

    services.xserver.windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        src = pkgs.fetchFromGitHub {
          owner = "ebadfd";
          repo = "dwm";
          rev = "3f6cf3d0d511110fd4fba3c89722f289f15c89be";
          hash = "sha256-69iHYr2258idJdzvQOj2rxWSKDs3eENBQzK+UlVEpoI=";
        };
      };
    };

    environment = { };

    home-manager.users.${vars.user} = {
      home = {
        file.".xinitrc" = {
          executable = true;
          text = # bash
            ''
              exec dwm
            '';
        };
      };

    };

  };
}

