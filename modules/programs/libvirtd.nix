{
  config,
  pkgs,
  vars,
  inputs,
  ...
}:

{
  programs.virt-manager.enable = true;

  users.users.${vars.user}.extraGroups = [ "libvirtd" ];

  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };
}
