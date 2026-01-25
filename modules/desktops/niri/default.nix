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
    niri = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.niri.enable) {
    environment.sessionVariables = {
      CLUTTER_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_DESKTOP = "niri";
      QT_QPA_PLATFORMTHEME = "qt6ct";
      NIRI_CONFIG = "$HOME/.config/niri/config.kdl";
    };

    services = {
      greetd = let
        session = {
          command = "${pkgs.niri}/bin/niri-session";
          user = "${vars.user}";
        };
      in {
        enable = true;
        settings = {
          terminal.vt = 1;
          default_session = session;
          initial_session = session;
        };
      };
      libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = false;
          accelSpeed = "0.5";
        };
      };
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
    };

    security.pam.services.greetd.enableGnomeKeyring = true;
    services.gnome.gnome-keyring.enable = true;

    programs.xwayland.enable = true;

    environment.systemPackages = with pkgs; [
      niri
      wl-clipboard
      cliphist
      brightnessctl
      swaybg
      waybar
      grim
      slurp
      wf-recorder
      wlr-randr
      wayland-utils
      xdg-utils
      libnotify
      wmenu
    ];

    home-manager.users.${vars.user} = {
      xdg.configFile."niri/config.kdl" = {
        text = import ./_config.nix { inherit pkgs vars; };
      };
    };
  };
}
