{ config, lib, pkgs, vars, ... }:

with lib;
{

  options = {
    zsh = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
      promptInit = mkOption {
        type = types.str;
        default = ''# hello world'';
      };
    };
  };

  config = mkIf (config.zsh.enable) {

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

        promptInit = config.zsh.promptInit;

        shellInit = ''
          # starship
          # eval "$(starship init zsh)"
        '';
      };
    };
  };
}


