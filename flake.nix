{
  description = "A flake for configuring my computers.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    stylix.url = "github:danth/stylix/release-24.05";

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , nixpkgs-stable
    , nixos-hardware
    , stylix
    , home-manager
    , home-manager-stable
    , ...
    }:
    let
      vars = {
        user = "dasith";
        email = "dasith@ebadfd.tech";
        location = "$HOME/nix-config";
        terminal = "alacritty";
        editor = "nvim";
        stateVersion = "24.05";
      };
    in
    {

      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-stable nixos-hardware home-manager stylix vars;
        }
      );
    };
}
