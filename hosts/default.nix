{ inputs, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, stylix, vars, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  stable = import nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  # thinkpad t480 profile
  kishi = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system stable vars;
      host = {
        hostName = "kishi";
      };
    };
    modules = [
      ./kishi
      ./configuration.nix
      stylix.nixosModules.stylix

      nixos-hardware.nixosModules.lenovo-thinkpad-t480
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };

  # vm profile
  vm = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system stable vars;
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
