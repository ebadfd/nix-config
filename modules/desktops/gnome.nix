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
    gnome = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.gnome.enable) {
    programs = {
      zsh.enable = true;
    };

    services = {
      libinput.enable = true;
      xserver = {
        enable = true;
        xkb = {
          layout = "us";
          options = "eurosign:e";
        };
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
    };

    environment = {
      systemPackages = with pkgs; [
        dconf-editor
        epiphany
        geary
        gnome-tweaks
        yelp
      ];
      gnome.excludePackages = (
        with pkgs;
        [
          # gnome-tour
        ]
      );
    };

    home-manager.users.${vars.user} = {
      dconf.settings = {
        "org/gnome/shell" = {
          # favorite-apps = [
          #   "org.gnome.settings.desktop"
          #   "kitty.desktop"
          #   "firefox.desktop"
          #   "org.gnome.nautilus.desktop"
          #   "com.obsproject.studio.desktop"
          # ];
          disable-user-extensions = false;
          enabled-extensions = [
            "blur-my-shell@aunetx"
            "caffeine@patapon.info"
            "pip-on-top@rafostar.github.com"
            "forge@jmmaranan.com"
            "system-monitor@gnome-shell-extensions.gcampax.github.com"
          ];
        };

        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          enable-hot-corners = false;
          clock-show-weekday = true;
          show-battery-percentage = true;
        };
        "org/gnome/desktop/privacy" = {
          report-technical-problems = "false";
        };
        "org/gnome/desktop/calendar" = {
          show-weekdate = true;
        };
        "org/gnome/mutter" = {
          workspaces-only-on-primary = false;
          center-new-windows = true;
          edge-tiling = false; # Tiling
        };
      };

      home.packages = with pkgs.gnomeExtensions; [
        blur-my-shell
        caffeine
        forge
        pip-on-top
        system-monitor
      ];
    };
  };
}
