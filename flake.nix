{
  description = "A flake for configuring my computers.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    stylix.url = "github:danth/stylix/release-24.11";

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    base16-tmux = {
      flake = false;
      url = "github:tinted-theming/base16-tmux";
    };

    stylix.inputs.base16-tmux.follows = "base16-tmux";

    plugin-cozy-bear = {
      url = "https://github.com/ebadfd/cozy-bear-nvim/";
      flake = false;
    };

   nixvim = {
       url = "github:nix-community/nixvim/nixos-24.11";
       inputs.nixpkgs.follows = "nixpkgs-stable";
   };

   firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
   };
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , nixpkgs-stable
    , nixos-hardware
    , stylix
    , nixvim
    , home-manager
    , firefox-addons
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
        stateVersion = "24.11";
      };
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-stable nixos-hardware home-manager stylix nixvim firefox-addons vars;
        }
      );
    };
}
