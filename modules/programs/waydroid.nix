{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
{
  config = mkIf config.wlwm.enable {
    virtualisation.waydroid = {
      enable = true;
      # Use nftables version for modern kernels (6.17+) that don't have ip_tables
      package = pkgs.waydroid-nftables;
    };

    networking.firewall.enable = true;
    networking.nftables.enable = true;
  };
}
