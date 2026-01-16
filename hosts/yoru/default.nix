{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  x11wm.enable = true;
  dwm.enable = true;
  fprint.enable = true;
  plymouth.enable = true;
  ratbagd.enable = true;
  syncthing.enable = true;
  twingate.enable = true;

  environment.systemPackages = with pkgs; [
    hello
  ];

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [
        3001
        8081
      ];
      allowedUDPPortRanges = [ ];
    };

    enableIPv6 = true;
    defaultGateway6 = null;
  };
}
