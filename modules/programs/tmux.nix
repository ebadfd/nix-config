{ pkgs, vars, ... }:

{
  home-manager.users.${vars.user} = {
    programs = {
      tmux = {
        enable = true;
        terminal = "tmux-256color";
        historyLimit = 100000;
        keyMode = "vi";
        escapeTime = 0;
        baseIndex = 1;

        extraConfig = ''
          unbind C-b
          set-option -g prefix C-a
          bind-key C-a send-prefix
          set -g default-shell ${pkgs.zsh}/bin/zsh

          # split current window horizontally
          bind - split-window -v
          # split current window vertically
          bind | split-window -h

          bind r source-file ~/.config/tmux/tmux.conf

          bind -T copy-mode-vi v send-keys -X begin-selection
          bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

          # vim-like pane switching
          bind -r ^ last-window
          bind -r k select-pane -U
          bind -r j select-pane -D
          bind -r h select-pane -L
          bind -r l select-pane -R

          bind-key -r f display-popup -E "~/.local/bin/tmux-sessionizer"

          set -g status-style "bg=#1a1a1a,fg=#a0a0a0"
          set -g window-status-current-style "bg=#2a2a2a,fg=#6aacac,bold"
          set -g window-status-style "bg=#1a1a1a,fg=#707070"
          set -g pane-active-border-style "fg=#6aacac"
          set -g pane-border-style "fg=#505050"
          set -g status-left "#[bg=#2a2a2a,fg=#6aacac] #S #[default] "
          set -g status-right "#[fg=#a0a0a0] %H:%M "
        '';
      };
    };
  };
}
