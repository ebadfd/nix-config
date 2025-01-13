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
  plymouth.enable = true;
  ratbagd.enable = true;

  environment = {
    systemPackages = with pkgs; [
      hello # Hello World
    ];
  };
}

