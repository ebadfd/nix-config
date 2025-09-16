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
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/6085b3f8-973e-4e0f-98e2-f2b7bbf4fd35";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A336-6800";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
  ];

  hardware.graphics.enable = true;

  networking = with host; {
    useDHCP = lib.mkDefault true;
    hostName = hostName;
    extraHosts = ''
      127.0.0.2 yoru
      127.0.0.1 localhost
    '';
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
