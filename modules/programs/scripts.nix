{ pkgs, vars, ... }:

{
  home-manager.users.${vars.user} = {
   home.sessionPath = [
      "$HOME/.local/bin"
   ];
   home.file = {
      ".local/bin/tmux-sessionizer" = {
        source = ./bin/tmux-sessionizer;
        executable = true;
      };
      ".zsh_profile" = {
        source = ./bin/zsh_profile;
      };
    };
  };
}
