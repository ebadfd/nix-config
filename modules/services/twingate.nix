{ config, lib, vars, ... }:
{
  config = lib.mkIf (config.twingate.enable) {
    services.twingate = {
      enable = false;
    };
  };
}
