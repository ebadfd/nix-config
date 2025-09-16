{
  config,
  lib,
  ...
}:

with lib;
{
  options = {
    fprint = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.fprint.enable) {
    services.fprintd.enable = true;
  };
}
