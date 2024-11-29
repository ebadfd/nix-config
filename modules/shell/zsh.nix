{ config, lib, pkgs, vars, ... }:

with lib;
{

  options = {
    zsh = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.zsh.enable) {
    users.users.${vars.user} = {
      shell = pkgs.zsh;
    };

    home-manager.users.${vars.user} = {
      programs = {
        zsh = {
          enable = true;
          autosuggestions.enable = true;
          syntaxHighlighting.enable = true;
          enableCompletion = true;
          shellAliases = {
            ll = "ls -al";
          };

          histSize = 100000;

          oh-my-zsh = {
            enable = true;
            plugins = [ "git" ];
          };

          initExtra = ''
            export EDITOR=nvim
          '';
        };
      };
      starship = {
        package = pkgs.nixpkgs.starship;
        enable = true;

        settings = {
          battery = {
            full_symbol = "🔋";
            charging_symbol = "🔌";
            discharging_symbol = "⚡";
            display = [
              {
                style = "bold red";
                threshold = 30;
              }
            ];
          };

          character = {
            error_symbol = "[✖](bold red) ";
          };

          cmd_duration = {
            min_time = 10000; # Show command duration over 10,000 milliseconds (=10 sec)
            format = " took [$duration]($style)";
          };

          directory = {
            truncation_length = 5;
            format = "[$path]($style)[$lock_symbol]($lock_style) ";
          };

          git_branch = {
            format = " [$symbol$branch]($style) ";
            symbol = "🍣 ";
            style = "bold yellow";
          };

          git_commit = {
            commit_hash_length = 8;
            style = "bold white";
          };

          git_state = {
            format = "[($state( $progress_current of $progress_total))]($style) ";
          };

          git_status = {
            conflicted = "⚔️ ";
            ahead = "🏎️ 💨 ×\${count}";
            behind = "🐢 ×\${count}";
            diverged = "🔱 🏎️ 💨 ×\${ahead_count} 🐢 ×\${behind_count}";
            untracked = "🛤️  ×\${count}";
            stashed = "📦 ";
            modified = "📝 ×\${count}";
            staged = "🗃️  ×\${count}";
            renamed = "📛 ×\${count}";
            deleted = "🗑️  ×\${count}";
            style = "bright-white";
            format = "$all_status$ahead_behind";
          };

          hostname = {
            ssh_only = false;
            format = "<[$hostname]($style)>";
            trim_at = "-";
            style = "bold dimmed white";
            disabled = true;
          };
        };
      };
    };

  };

}

