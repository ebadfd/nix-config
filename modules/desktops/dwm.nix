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
              sha256 = "sha256-9u6UoJcda92iPCXXupS+F55yh/H3n/DmHS+vVqjLZFc=";
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
          text =
            ''
              $HOME/.xsession
            '';
        };
      };
    };

    nixpkgs.overlays = [
        (final: prev: {
         slstatus = prev.slstatus.overrideAttrs (old: { 
            src = pkgs.fetchFromGitHub {
              owner = "ebadfd";
              repo = "slstatus";
              rev = "master";
              sha256 = "sha256-2GOzHgdp3En8Sru7DXgomS9AfA2rqNcL0ftceMoAkI8=";
              # sha256 = lib.fakeSha256;
            };
 	  });
        })
    ];

    environment = {
      systemPackages = with pkgs; [
	slstatus
      ];
    };
  };
}
