{
  pkgs,
  lib,
  vars,
  ...
}:
{
  home-manager.users.${vars.user} = {
    home.sessionPath = [
      "$HOME/.local/bin"
    ];
    home.file = {
      ".local/bin/tmux-sessionizer" = {
        source = ./bin/tmux-sessionizer;
        executable = true;
      };
      ".zsh_profile" = {
        source = ./bin/zsh_profile;
      };
      ".local/bin/umacaddr" = {
        source = ./bin/umacaddr;
        executable = true;
      };
      ".local/bin/brctl" = {
        source = ./bin/brctl;
        executable = true;
      };
    };
  };

  environment.systemPackages = [
    (pkgs.stdenv.mkDerivation {
      name = "local-vault";

      src = pkgs.fetchurl {
        name = "local-vault";
        url = "https://github.com/ebadfd/local-vault/releases/download/0.0.1-beta/local-vault_0.0.1-beta_linux_amd64.tar.gz";
        sha256 = "sha256-hFsAQTAo62BFymM4sBYSCKPmJkXz3SGFiKzRHq/3C2I=";
        # sha256 = lib.fakeSha256;
      };

      phases = [ "installPhase" ];

      installPhase = ''
        mkdir -p $out/bin
        tar -xf $src -C $out/bin
      '';
    })
  ];

}
