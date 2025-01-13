{ config, lib, pkgs, vars, ... }:
{
  programs.zsh = {
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
       plugins = [ "git" "aliases" "aws" "battery"];
       theme = "refined";
     };
  };

  users.users.${vars.user} = {
    shell = pkgs.zsh;
  };
}
