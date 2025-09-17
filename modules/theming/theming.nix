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
    };
  };

  environment.variables = {
    QT_QPA_PLATFORMTHEME = lib.mkForce "qt5ct";
  };
}
