{ pkgs, vars, ... }:

{
  home-manager.users.${vars.user} = {
   home.sessionPath = [
      "$HOME/.local/bin"
   ];
   home.file = {
      ".local/bin" = {
        source = ./bin;
        recursive = true;
      };
    };
  };
}
