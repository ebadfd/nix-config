{ config, lib, vars, ... }:
{
  config = lib.mkIf (config.syncthing.enable) {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      user = vars.user;
      configDir = "/home/${vars.user}/.config/syncthing";
      guiAddress = "127.0.0.1:8384";
    };
  };
}
