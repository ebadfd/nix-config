{ config, lib, pkgs, vars, ... }:
{
   home-manager.users.${vars.user} = {
     programs.neovim = {
    	enable = true;
      };

     xdg.configFile."nvim".source = ./nvim;
   };
}
