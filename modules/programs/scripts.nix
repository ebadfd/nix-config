{ pkgs, vars, ... }:

{
  home-manager.users.${vars.user} = {
   home.file = {
      ".local/bin" = {
        source = ./bin;
        recursive = true;
      };
    };
  };
}
