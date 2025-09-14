{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # gnome.enable = false;
  x11wm.enable = true;
  dwm.enable = true;
  fprint.enable = false;
  plymouth.enable = true;
  ratbagd.enable = true;
  syncthing.enable = true;
  twingate.enable = true;

  environment = {
    systemPackages = with pkgs; [
      hello # Hello World
    ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 3001 ];
    allowedUDPPortRanges = [ ];
  };
}
