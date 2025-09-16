#
#  GTK
#

{
  lib,
  config,
  pkgs,
  host,
  vars,
  ...
}:

{
  home-manager.users.${vars.user} = {
    gtk = lib.mkIf (config.gnome.enable == false) {
      enable = true;

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = lib.mkForce "adwaita-dark";
      #  stylix: qt: Changing `config.qt.style` is unsupported and may result in breakage! Use with caution!
      style = {
        name = lib.mkForce "adwaita-dark";
        package = pkgs.adwaita-qt6;
      };
    };
  };

  # environment.variables = {
  #   QT_QPA_PLATFORMTHEME = "gtk2";
  # };
}

#    qt.enable = lib.mkForce false;
#    qt.platformTheme.name = lib.mkForce "gtk";
#    qt.style.name = lib.mkForce null;
