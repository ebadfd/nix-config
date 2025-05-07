{
  config,
  lib,
  host,
  ...
}:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [
    "ata_piix"
    "uhci_hcd"
    "virtio_pci"
    "virtio_scsi"
    "sd_mod"
    "sr_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/98781e0e-b2cf-44d4-b3b5-0d46fe1be42a";
    fsType = "ext4";
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/1e0166e2-1b9a-46f9-8359-a92d094c37a7";
    }
  ];

  networking = with host; {
    useDHCP = lib.mkDefault true;
    hostName = hostName;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
