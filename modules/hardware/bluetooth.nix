#
#  Bluetooth
#

{ pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez5-experimental;
    settings = {
      Policy = {
        AutoEnable = true;
      };
      General = {
        Name = "kishi_bluez";
        AutoEnable = true;
      };
    };
  };
  services.blueman.enable = true;
  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [
      "network.target"
      "sound.target"
    ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };
}
