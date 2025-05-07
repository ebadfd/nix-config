{ inputs, nixpkgs, nixpkgs-stable, nix-darwin, home-manager, nixvim, stylix, vars, ... }:

let
  systemConfig = system: {
    system = system;
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  };
in
{
  # MacBookPro,1 M1 14" Yuna
  yuna =
    let
      inherit (systemConfig "aarch64-darwin") system pkgs stable;
    in
    nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit inputs system pkgs stable vars; };
      modules = [
       stylix.darwinModules.stylix
        ./darwin-configuration.nix
        ./m1.nix
        nixvim.nixDarwinModules.nixvim
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ];
    };
}
