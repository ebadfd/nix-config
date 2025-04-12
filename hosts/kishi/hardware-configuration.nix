{ config, lib, host, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/b201983a-80b5-46e6-83d8-c2e8a66dcc4e";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/F041-11EF";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ 
      {
        device = "/dev/disk/by-uuid/04eb8b64-b31e-44ee-8393-fc5181b5a330";
      }
    ];

  networking = with host; {
    useDHCP = lib.mkDefault true;
    hostName = hostName;
    extraHosts = ''
      127.0.0.2 kishi
      127.0.0.1 localhost
    '';
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
