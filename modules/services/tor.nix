{
  config,
  lib,
  vars,
  ...
}:
{
  config = lib.mkIf (config.twingate.enable) {
    services.tor = {
      enable = true;
      openFirewall = true;
      torsocks = {
        enable = true;
        server = "127.0.0.1:9050";
      };
      client = {
        enable = true;
      };
      relay = {
        enable = true;
        role = "relay";
      };
      settings = {
        ContactInfo = "toradmin@ebadfd.tech";
        Nickname = "toradmin";
        ORPort = 9001;
        ControlPort = 9051;
        BandWidthRate = "1 MBytes";
      };
    };
  };
}
