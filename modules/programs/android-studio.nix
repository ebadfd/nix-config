{ vars, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.android-studio
    pkgs.android-tools
  ];

  users.users.${vars.user} = {
    isNormalUser = true;
    extraGroups = [ "adbusers" ];
  };
}
