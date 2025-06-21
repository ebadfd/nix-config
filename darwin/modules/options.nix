{ lib, ... }:

with lib;
{
  options = {
    twingate = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    syncthing = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
}
