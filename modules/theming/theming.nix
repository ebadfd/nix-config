#
#  GTK
#

{ lib, config, pkgs, host, vars, ... }:

{
  home-manager.users.${vars.user} = {
    gtk = lib.mkIf (config.gnome.enable == false) {
      enable = true;
    };

    # qt = {
    #   enable = true;
    #   platformTheme.name = "gtk";
    #   style = {
    #     name = "adwaita-dark";
    #     package = pkgs.adwaita-qt;
    #   };
    # };
  };

  # environment.variables = {
  #   QT_QPA_PLATFORMTHEME = "gtk2";
  # };
}
