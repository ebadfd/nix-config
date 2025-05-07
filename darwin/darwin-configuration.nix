{ pkgs, vars, ... }:

{
  imports = (import ./modules);

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
      # Terminal
      btop # Resource Manager
      coreutils # GNU Utilities
      mas # Mac App Store $ mas search <app>
      git # Version Control
      killall # Process Killer
      nano # Text Editor

      nix-tree # Browse Nix Store
      pciutils # Manage PCI
      ranger # File Manager
      tldr # Helper
      usbutils # Manage USB
      wget # Retriever
      curl
      xdg-utils # Environment integration
      vim # VIM

      feh # Image Viewer
      mpv # Media Player

      # Apps
      remmina # XRDP & VNC Client

      # File Management
      unzip # Zip Files
      unrar # Rar Files
      zip # Zip

      dmenu # dmenu

      gnupg # pgp
      gnumake
      ripgrep # rip grep

      dbgate # database management
      pgadmin4-desktopmode # postgresql management

      awscli2 # aws cli
      kubectl # kubernets cli

      dig # domain name server

      # Other Packages Found @
      # - ./<host>/default.nix
      # - ../modules
      nmap
      terraform
      fluxcd
      signal-desktop
      cmake
      clang
      libtool
      hurl
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
    casks = pkgs.callPackage ./casks.nix { };
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

  ids.gids.nixbld = 350;
  system = {
    stateVersion = 4;
  };
}
