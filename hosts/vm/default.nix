{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
        configurationLimit = 5;
      };
      timeout = 1;
    };
  };

  # gnome.enable = false;
  x11wm.enable = true;
  dwm.enable = true;

  environment = {
    systemPackages = with pkgs; [
      hello # Hello World
    ];
  };

  services = {
    xserver = {
      resolutions = [
        { x = 1920; y = 1080; }
        { x = 1600; y = 900; }
        { x = 3840; y = 2160; }
      ];
    };
  };
}
