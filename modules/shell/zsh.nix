{ pkgs, vars, ... }:

{
  users.users.${vars.user} = {
    shell = pkgs.zsh;
  };

  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      shellAliases = {
        ll = "ls -al";
      };

      histSize = 100000;

      ohMyZsh = {
        enable = true;
        plugins = [ "git" ];
      };

      shellInit = ''
        # starship
        # eval "$(starship init zsh)"
      '';
    };
  };
}

