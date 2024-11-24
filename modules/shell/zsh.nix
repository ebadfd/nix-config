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
      histSize = 100000;

      ohMyZsh = {
        enable = true;
        plugins = [ "git" ];
      };
    };
    starship = {
      enable = true;
    };
  };
}

