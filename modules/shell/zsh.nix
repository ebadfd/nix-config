{ pkgs, vars, ... }:
{
  programs.zsh = {
     enable = true;
     autosuggestions.enable = true;
     syntaxHighlighting.enable = true;
     enableCompletion = true;
     shellAliases = {
       ll = "ls -al";
        v = "nvim";
     };

     histSize = 100000;

    promptInit  = ''
source /home/${vars.user}/.zsh_profile
    '';

     ohMyZsh = {
       enable = true;
       plugins = [ "git" "aliases" "aws" "battery"];
       theme = "refined";
     };
  };

  users.users.${vars.user} = {
    shell = pkgs.zsh;
  };
}

