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
	  set -g status-style 'bg=#333333 fg=#5eacd3'

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
	'';
      };
    };
  };
}
