{ config, lib, pkgs, vars, ... }:
{
  config = lib.mkIf (config.syncthing.enable) {
    enable = true;
    openDefaultPorts = true;
    configDir = "/home/${vars.user}/.config/syncthing";
    user = vars.user;
    guiAddress = "127.0.0.1:8384";

    declarative = {
      overrideDevices = true;
      overrideFolders = true;      
    };
  };
}
