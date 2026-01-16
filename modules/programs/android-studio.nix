{ vars, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.android-studio ];

  programs.adb.enable = true;

  users.users.${vars.user} = {
    isNormalUser = true;
    extraGroups = [ "adbusers" ];
  };
}
