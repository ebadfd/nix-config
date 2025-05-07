{ pkgs, vars, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      eza # Ls
    ];
  };

  home-manager.users.${vars.user} = {
    programs = {
      zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        enableCompletion = true;
        history.size = 10000;

        shellAliases = {
          ll = "ls -al";
          v = "nvim";
          k = "kubectl";
          pbcopy = "xclip -selection clipboard";
          nix-shell="nix-shell --run zsh";
          nix-develop="nix develop -c zsh";

          killbt = "rfkill block bluetooth";
          unKillbt = "rfkill unblock bluetooth";
        };

        oh-my-zsh = {
          enable = true;
          plugins = [ "git" "aliases" "aws" "battery" "macos"];
          theme = "refined";
        };
      };
    };
  };
}
