{ config, lib, pkgs, vars, ... }:
{
  config = lib.mkIf (config.ratbagd.enable) {
    services.ratbagd.enable = true;

    environment = {
      systemPackages = with pkgs; [
	piper
      ];
    };
  };
}
