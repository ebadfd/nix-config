{ pkgs, vars, ... }:
{
  home-manager.users.${vars.user} = {
    home = {
      packages = with pkgs; [
        go
      ];
    };
  };
}
