{ vars, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.android-studio ];
}
