{
  inputs,
  nixpkgs,
  nixpkgs-stable,
  nixos-hardware,
  home-manager,
  stylix,
  emacs-overlay,
  nixvim,
  vars,
  ...
}:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    overlays = [
      emacs-overlay.overlay
      (final: prev: {
        slstatus = prev.slstatus.overrideAttrs (old: {
          src = pkgs.fetchFromGitHub {
            owner = "ebadfd";
            repo = "slstatus";
            rev = "master";
            sha256 = "sha256-pLqfdgeEO1cAewi9UwIXDnIAK4/+4HIpgFGwJVtMAKI=";
            # sha256 = lib.fakeSha256;
          };
        });
      })
    ];
    config = {
      allowUnfree = true;
    };
  };

  stable = import nixpkgs-stable {
    inherit system;
    overlays = [
      emacs-overlay.overlay
      (final: prev: {
        slstatus = prev.slstatus.overrideAttrs (old: {
          src = pkgs.fetchFromGitHub {
            owner = "ebadfd";
            repo = "slstatus";
            rev = "master";
            sha256 = "sha256-pLqfdgeEO1cAewi9UwIXDnIAK4/+4HIpgFGwJVtMAKI=";
            # sha256 = lib.fakeSha256;
          };
        });
      })
    ];
    config = {
      allowUnfree = true;
    };
  };

  lib = nixpkgs.lib;
in
{
  # thinkpad t480 profile
  kishi = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit
        inputs
        system
        stable
        vars
        pkgs
        ;
      host = {
        hostName = "kishi";
      };
    };
    modules = [
      ./kishi
      ./configuration.nix
      stylix.nixosModules.stylix
      nixvim.nixosModules.nixvim

      nixos-hardware.nixosModules.lenovo-thinkpad-t480
      home-manager.nixosModules.home-manager
      {
        home-manager.backupFileExtension = "hmbackup";
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };

  # vm profile
  vm = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit
        inputs
        system
        stable
        vars
        ;
      host = {
        hostName = "vm";
      };
    };
    modules = [
      ./vm
      ./configuration.nix

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}
