{
  config,
  lib,
  pkgs,
  vars,
  ...
}:

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
    services = {
      libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = false;
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
              rev = "master";
              sha256 = "sha256-Er/O8xnJft1CWjru7eLUxXul18a2W16uGUkeV7/Dlgo=";
              # sha256 = lib.fakeSha256;
            };
          };
        };

      };
    };

    environment = {
      loginShellInit = ''
        # Start graphical server on user's current tty if not already running.
        [ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC" &> /dev/null
      '';
    };

    home-manager.users.${vars.user} = {
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
          	  
                    slstatus &
                    nm-applet &
                    blueman-applet &

                    ~/.fehbg
        '';
      };
      home = {
        file.".xinitrc" = {
          executable = true;
          text = ''
            $HOME/.xsession
          '';
        };
      };
    };

    environment = {
      systemPackages = with pkgs; [
        slstatus
      ];
    };
  };
}
