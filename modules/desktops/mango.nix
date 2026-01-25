{
  config,
  lib,
  pkgs,
  vars,
  mango,
  ...
}:

with lib;
{
  imports = [ mango.nixosModules.mango ];

  options = {
    mango = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
      greeter = mkOption {
        type = types.enum [
          "tui"
          "regreet"
        ];
        default = "regreet";
        description = "Which greeter to use: 'tui' for tuigreet or 'regreet' for graphical GTK4 greeter";
      };
    };
  };

  config = mkIf (config.mango.enable) {
    security.rtkit.enable = true;
    security.polkit.enable = true;
    security.pam.services.swaylock = {
      fprintAuth = false;
    };

    programs.mango.enable = true;

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      WLR_NO_HARDWARE_CURSORS = "1";
      XDG_CURRENT_DESKTOP = "mango";
    };

    # TUI greeter configuration
    services.greetd = mkIf (config.mango.greeter == "tui") {
      enable = true;
      settings = {
        default_session = {
          command = ''
            ${pkgs.tuigreet}/bin/tuigreet \
              --time \
              --time-format "%Y-%m-%d %H:%M" \
              --greeting "Welcome" \
              --asterisks \
              --remember \
              --remember-user-session \
              --theme "border=cyan;text=white;prompt=cyan;time=gray;action=cyan;button=white;container=black;input=white" \
              --cmd mango
          '';
          user = "greeter";
        };
      };
    };

    # ReGreet graphical greeter configuration
    programs.regreet = mkIf (config.mango.greeter == "regreet") {
      enable = true;
      settings = {
        background = {
          path = lib.mkForce ../../wallpaper.png;
          fit = "Cover";
        };
        commands = {
          reboot = [
            "systemctl"
            "reboot"
          ];
          poweroff = [
            "systemctl"
            "poweroff"
          ];
        };
      };
      cageArgs = [ "-s" ];
    };

    environment.etc."greetd/environments".text = ''
      mango
    '';

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    home-manager.users.${vars.user} = {
      home.file."Pictures/Screenshots/.keep".text = "";

      wayland.windowManager.mango = {
        enable = true;
        settings = ''
          # Autostart
          exec-once=~/.config/mango/autostart.sh

          # Monitor layout - eDP-1 left, HDMI-A-1 right
          monitorrule=eDP-1,0.55,1,tile,0,1,0,0,1920,1080,60
          monitorrule=HDMI-A-1,0.55,1,tile,0,1,1920,0,1920,1080,60

          # Theme colors (matching dark Art Nouveau wallpaper)
          borderpx=2
          bordercolor=0x1e2625ff
          focuscolor=0x6aacacff
          urgentcolor=0xc07070ff
          border_radius=0

          # Disable hotcorner overview
          hotarea_size=0

          # Animation Configuration
          animations=1
          layer_animations=1
          animation_type_open=zoom
          animation_type_close=zoom
          layer_animation_type_open=slide
          layer_animation_type_close=slide
          animation_fade_in=1
          animation_fade_out=1
          tag_animation_direction=1
          animation_duration_move=300
          animation_duration_open=250
          animation_duration_tag=200
          animation_duration_close=200
          animation_duration_focus=200
          animation_curve_open=0.25,0.1,0.25,1.0
          animation_curve_move=0.25,0.1,0.25,1.0
          animation_curve_tag=0.25,0.1,0.25,1.0
          animation_curve_close=0.25,0.1,0.25,1.0
          animation_curve_focus=0.25,0.1,0.25,1.0

          # Terminal
          bind=SUPER,Return,spawn,alacritty

          # Close window
          bind=SUPER+SHIFT,q,killclient,
          bind=SUPER,d,spawn,wmenu-run -p "run:" -N "#0d0f0f" -n "#b0c0b0" -M "#1e2625" -m "#6aacac" -S "#1e2625" -s "#6aacac"

          # Quit mango
          bind=SUPER+SHIFT,e,quit

          # Focus windows
          bind=SUPER,j,focusdir,down
          bind=SUPER,k,focusdir,up
          bind=SUPER,h,focusdir,left
          bind=SUPER,l,focusdir,right

          # Move/swap windows
          bind=SUPER+SHIFT,j,exchange_client,down
          bind=SUPER+SHIFT,k,exchange_client,up
          bind=SUPER+SHIFT,h,exchange_client,left
          bind=SUPER+SHIFT,l,exchange_client,right

          # Resize windows
          bind=SUPER+CTRL,h,resizewin,-50,+0
          bind=SUPER+CTRL,l,resizewin,+50,+0
          bind=SUPER+CTRL,k,resizewin,+0,-50
          bind=SUPER+CTRL,j,resizewin,+0,+50

          # Fullscreen
          bind=SUPER,f,togglefullscreen

          # Toggle floating
          bind=SUPER+SHIFT,space,togglefloating
          bind=SUPER,t,togglefloating

          # View tags
          bind=SUPER,1,view,1,0
          bind=SUPER,2,view,2,0
          bind=SUPER,3,view,3,0
          bind=SUPER,4,view,4,0
          bind=SUPER,5,view,5,0
          bind=SUPER,6,view,6,0
          bind=SUPER,7,view,7,0
          bind=SUPER,8,view,8,0
          bind=SUPER,9,view,9,0

          # Move window to tag
          bind=SUPER+SHIFT,1,tag,1,0
          bind=SUPER+SHIFT,2,tag,2,0
          bind=SUPER+SHIFT,3,tag,3,0
          bind=SUPER+SHIFT,4,tag,4,0
          bind=SUPER+SHIFT,5,tag,5,0
          bind=SUPER+SHIFT,6,tag,6,0
          bind=SUPER+SHIFT,7,tag,7,0
          bind=SUPER+SHIFT,8,tag,8,0
          bind=SUPER+SHIFT,9,tag,9,0

          # Navigate tags
          bind=SUPER,Left,viewtoleft,0
          bind=SUPER,Right,viewtoright,0

          # Lock screen
          bind=SUPER+SHIFT,c,spawn,swaylock

          # Screenshots (using satty for annotation)
          bind=SUPER,p,spawn_shell,grim -g "$(slurp)" - | satty --filename -

          # Overview mode (disabled)
          # bind=SUPER,Tab,toggleoverview

          # Reload config
          bind=SUPER,r,reload_config
          bind=SUPER+SHIFT,r,reload_config

          # Monitor focus
          bind=SUPER+ALT,h,focusmon,left
          bind=SUPER+ALT,l,focusmon,right
          bind=SUPER+SHIFT+ALT,h,tagmon,left
          bind=SUPER+SHIFT+ALT,l,tagmon,right
        '';

        autostart_sh = ''
          swaybg -i /home/${vars.user}/nix-config/wallpaper.png -m center -c '#0d0f0f' &
          sleep 0.5 && waybar &
          mako &
          nm-applet &
          blueman-applet &
        '';
      };

      xdg.configFile."swaylock/config".text = ''
        color=0d0f0f
        font-size=24
        indicator-idle-visible=false
        indicator-radius=100
        line-color=0d0f0f
        show-failed-attempts=true
        text-color=b0c0b0
        text-clear-color=b0c0b0
        text-ver-color=b0c0b0
        text-wrong-color=c07070
        separator-color=0d0f0f
      '';

      programs = {
        waybar = {
          enable = true;
          settings = {
            mainBar = {
              layer = "top";
              position = "top";
              height = 26;
              spacing = 0;
              modules-left = [ "ext/workspaces" ];
              modules-center = [ ];
              modules-right = [
                "tray"
                "pulseaudio"
                "network"
                "battery"
                "clock"
              ];

              "ext/workspaces" = {
                format = "{id}";
                ignore-hidden = true;
                on-click = "activate";
                on-click-right = "deactivate";
                sort-by-id = true;
                persistent-workspaces = {
                  "*" = 9;
                };
              };

              tray = {
                icon-size = 14;
                spacing = 8;
              };

              pulseaudio = {
                format = "VOL {volume}%";
                format-muted = "MUTED";
                format-icons = {
                  default = [
                    ""
                    ""
                    ""
                  ];
                };
                scroll-step = 5;
                on-click = "pavucontrol";
                tooltip = true;
              };

              network = {
                format-wifi = "WIFI {essid} {signalStrength}%";
                format-ethernet = "ETH {ipaddr}";
                format-disconnected = "OFFLINE";
                tooltip-format-wifi = "{essid} ({signalStrength}%)\nIP: {ipaddr}\nUp: {bandwidthUpBits} Down: {bandwidthDownBits}";
                tooltip-format-ethernet = "{ifname}\nIP: {ipaddr}\nUp: {bandwidthUpBits} Down: {bandwidthDownBits}";
                on-click = "nm-connection-editor";
              };

              battery = {
                format = "BAT {capacity}%";
                format-charging = "CHG {capacity}%";
                format-plugged = "PLG {capacity}%";
                format-critical = "LOW {capacity}%";
                states = {
                  warning = 30;
                  critical = 15;
                };
                tooltip-format = "{timeTo}\n{power}W";
              };

              clock = {
                format = "{:%H:%M}";
                format-alt = "{:%a %d %b %Y}";
                tooltip-format = "<tt>{calendar}</tt>";
              };
            };
          };

          style = ''
            * {
              font-family: "FiraMono Nerd Font", monospace;
              font-size: 12px;
              min-height: 0;
            }

            window#waybar {
              background-color: #0d0f0f;
              color: #b0c0b0;
              border: none;
            }

            #workspaces button {
              padding: 0 0.4rem;
              margin: 0.15rem 0.1rem;
              border-radius: 0;
              background-color: #161a19;
              color: #5a6a5a;
              border: none;
            }

            #workspaces button:hover {
              background-color: #1e2625;
              color: #b0c0b0;
            }

            #workspaces button.active {
              background-color: #1e2625;
              color: #6aacac;
            }

            #workspaces button.urgent {
              background-color: #1e2625;
              color: #c07070;
            }

            #tray {
              padding: 0 6px;
            }

            #pulseaudio, #network, #battery, #clock, #tray {
              padding: 0 8px;
              margin: 0.15rem 0.1rem;
              background-color: #161a19;
              color: #b0c0b0;
            }

            #clock {
              color: #6aacac;
            }

            #battery {
              color: #7fb080;
            }

            #battery.warning {
              color: #d4a067;
            }

            #battery.critical {
              color: #c07070;
            }

            #network {
              color: #70a0b0;
            }

            #network.disconnected {
              color: #c07070;
            }

            #pulseaudio {
              color: #a08aad;
            }

            #pulseaudio.muted {
              color: #5a6a5a;
            }
          '';
        };
      };

      services.mako = {
        enable = true;
        settings = {
          border-radius = 0;
          border-size = 2;
          default-timeout = 5000;
          max-visible = 5;
        };
      };

      xdg.configFile."satty/config.toml".text = ''
        [general]
        fullscreen = true
        early-exit = true
        copy-command = "wl-copy"
        save-after-copy = true
        initial-tool = "brush"
        output-filename = "/home/${vars.user}/Pictures/Screenshots/screenshot-%Y%m%d_%H%M%S.png"

        [color-palette]
        palette = ["#c07070", "#7fb080", "#6aacac", "#b5c06a", "#a08aad"]
        custom = ["#b0c0b0"]
      '';
    };

    environment.systemPackages =
      with pkgs;
      [
        waybar
        swaybg
        swaylock
        mako
        grim
        slurp
        satty
        wl-clipboard
        alacritty
        pavucontrol
        brightnessctl
        blueman
        wmenu
        jq
        wlr-randr
      ]
      ++ lib.optionals (config.mango.greeter == "regreet") [
        adw-gtk3
      ];
  };
}
