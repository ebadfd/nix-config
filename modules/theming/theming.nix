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
    };

    qt = {
      enable = true;
    };
  };

  environment.variables = {
    QT_QPA_PLATFORMTHEME = lib.mkForce "qt5ct";
  };
}
