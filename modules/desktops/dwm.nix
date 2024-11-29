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

    services = {
      libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = true;
        };
      };
      displayManager = {
        defaultSession = "none+dwm";
      };
      xserver = {
        enable = true;
        autorun = true;
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
              hash = "sha256-69iHYr2258idJdzvQOj2rxWSKDs3eENBQzK+UlVEpoI=";
            };
          };
        };

      };
    };

    environment.etc = {
      "profile.local".text =
        ''
          # /etc/profile.local: DO NOT EDIT -- this file has been generated automatically.

          if [ -f "$HOME/.profile" ]; then
            . "$HOME/.profile"
          fi

          if [ -z "$DISPLAY" ] && [ "''${XDG_VTNR}" -eq 1 ]; then
            exec startx
          fi
        '';
    };

    home-manager.users.${vars.user} = {
      home = {
        file.".xinitrc" = {
          executable = true;
          text = # bash
            ''
              #! ${pkgs.bash}
              $HOME/.xsession
            '';
        };
      };
    };
    xsession = {
      enable = true;
      windowManager.command = "while type dwm > ~/.dwm.log; do dwm && continue || break; done";

      profileExtra = ''
        # https://nixos.wiki/wiki/Using_X_without_a_Display_Manager
        if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
          eval $(dbus-launch --exit-with-session --sh-syntax)
        fi
        systemctl --user import-environment DISPLAY XAUTHORITY

        if command -v dbus-update-activation-environment >/dev/null 2>&1; then
          dbus-update-activation-environment DISPLAY XAUTHORITY
        fi

        # Fix Java applications not rendering correctly on DWM
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';
    };
  };
}

