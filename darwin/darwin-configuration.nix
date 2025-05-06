{ pkgs, vars, ... }:

{
  # imports = (import ./modules);

  users.users.${vars.user} = {
    home = "/Users/${vars.user}";
    shell = pkgs.zsh;
  };

  environment = {
    variables = {
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
    systemPackages = with pkgs; [
      eza # Ls
      git # Version Control
      mas # Mac App Store $ mas search <app>
      ranger # File Manager
      tldr # Help
      wget # Download
    ];
  };

  programs = {
    zsh.enable = true;
    direnv = {
      enable = true;
      loadInNixShell = true;
      nix-direnv.enable = true;
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      upgrade = false;
      cleanup = "zap";
    };
    casks = [
      "obs"
      "vlc"
      # "canon-eos-utility"
    ];
  };

  home-manager.users.${vars.user} = {
    home.stateVersion = "24.11";
  };

  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      # auto-optimise-store = true
      experimental-features = nix-command flakes
    '';
  };

  system = {
    stateVersion = 4;
  };
}
