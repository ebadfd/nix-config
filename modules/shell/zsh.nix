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
      k = "kubectl";
      pbcopy = "xclip -selection clipboard";
      nix-shell = "nix-shell --run zsh";
      nix-develop = "nix develop -c zsh";

      killbt = "rfkill block bluetooth";
      unKillbt = "rfkill unblock bluetooth";
    };

    histSize = 100000;

    promptInit = ''
      source /home/${vars.user}/.zsh_profile
    '';

    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "aliases"
        "aws"
        "battery"
      ];
      theme = "refined";
    };
  };

  users.users.${vars.user} = {
    shell = pkgs.zsh;
  };
}
