{
  config,
  lib,
  vars,
  ...
}:
{
  config = lib.mkIf (config.twingate.enable) {
    services.twingate = {
      enable = true;
    };
    services.cloudflare-warp = {
      enable = false;
    };
  };
}
