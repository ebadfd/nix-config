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

    programs.zsh.enable = true;

    home-manager.users.${vars.user} = {
      programs = {
        zsh = {
          enable = true;
          oh-my-zsh = {
            enable = true;
            plugins = [ "git" ];
          };
          plugins = [
            {
              name = "zsh-autosuggestions";
              src = pkgs.fetchFromGitHub {
                owner = "zsh-users";
                repo = "zsh-autosuggestions";
                rev = "v0.7.0";
                sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
              };
            }
            {
              name = "zsh-completions";
              src = pkgs.fetchFromGitHub {
                owner = "zsh-users";
                repo = "zsh-completions";
                rev = "0.34.0";
                sha256 = "0jjgvzj3v31yibjmq50s80s3sqi4d91yin45pvn3fpnihcrinam9";
              };
            }
            {
              name = "zsh-syntax-highlighting";
              src = pkgs.fetchFromGitHub {
                owner = "zsh-users";
                repo = "zsh-syntax-highlighting";
                rev = "0.7.0";
                sha256 = "0s1z3whzwli5452h2yzjzzj27pf1hd45g223yv0v6hgrip9f853r";
              };
            }
          ];
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

