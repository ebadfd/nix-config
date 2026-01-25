{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Disable X11 WM and enable Wayland WM with Mango
  #x11wm.enable = true;
  #dwm.enable = true;

  wlwm.enable = true;
  mango.enable = true;
  mango.greeter = "tui";
  #niri.enable = true;
  #quickshell.enable = true;

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
