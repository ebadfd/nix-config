{
  config,
  lib,
  inputs,
  ...
}:
{
  config = lib.mkIf (config.plymouth.enable) {
    boot = {
      plymouth = {
        enable = true;

        themePackages = [ inputs.mikuboot.packages."x86_64-linux".default ];
        theme = "mikuboot";
      };

      # Enable "Silent Boot"
      consoleLogLevel = 0;
      initrd.verbose = false;

      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];

      # Hide the OS choice for bootloaders.
      # It's still possible to open the bootloader list by pressing any key
      # It will just not appear on screen unless a key is pressed
      loader.timeout = 0;
    };
  };
}
