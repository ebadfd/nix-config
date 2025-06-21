{ vars, pkgs, ... }:
{
  home-manager.users.${vars.user} = {
    home.file = {
      ".emacs.d/config.org" = {
        source = ./emacs/config.org;
      };
      ".emacs.d/init.el" = {
        source = ./emacs/init.el;
      };
      ".emacs.d/themes/cozy-bear-theme.el" = {
        source = ./emacs/cozy-bear-theme.el;
      };
    };

    programs.emacs = {
      enable = true;
      package = pkgs.emacsWithPackagesFromUsePackage {
        package = pkgs.emacs30-gtk3;

        config = ./emacs/config.org;
        alwaysEnsure = true;
        alwaysTangle = true;

        defaultInitFile = pkgs.writeTextFile {
          name = "default.el";
          text = builtins.readFile ./emacs/init.el;
        };

        extraEmacsPackages = epkgs: [
          epkgs.cask

          pkgs.rustup-toolchain-install-master
          pkgs.cargo
          pkgs.rustup
          pkgs.rust-analyzer

          pkgs.go
          pkgs.gopls

          pkgs.typescript-language-server
          pkgs.typescript

          (pkgs.python3.withPackages (
            p:
            (with p; [
              python-lsp-server
              python-lsp-ruff
              pylsp-mypy
            ])
          ))

          pkgs.htmx-lsp
          pkgs.terraform-ls
          pkgs.lua-language-server

          pkgs.nil
          pkgs.autotools-language-server

          pkgs.shellcheck
        ];
      };
    };
  };
}
