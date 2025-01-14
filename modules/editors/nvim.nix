{ pkgs, ... }:
{
  imports = [
    ./plugins/gitsigns.nix
    ./plugins/which-key.nix
    ./plugins/telescope.nix
    ./plugins/conform.nix
    ./plugins/lsp.nix
    ./plugins/nvim-cmp.nix
    ./plugins/mini.nix
    ./plugins/treesitter.nix
    ./plugins/kickstart/plugins/autopairs.nix
    ./plugins/kickstart/plugins/lint.nix
    ./plugins/kickstart/plugins/indent-blankline.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    globals = {
      # Set <space> as the leader key
      # See `:help mapleader`
      mapleader = " ";
      maplocalleader = " ";

      # Set to true if you have a Nerd Font installed and selected in the terminal
      have_nerd_font = true;
    };

    keymaps = [
      # Clear highlights on search when pressing <Esc> in normal mode
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
      }
      # Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
      # for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
      # is not what someone will guess without a bit more experience.
      #
      # NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
      # or just use <C-\><C-n> to exit terminal mode
      {
        mode = "t";
        key = "<Esc><Esc>";
        action = "<C-\\><C-n>";
        options = {
          desc = "Exit terminal mode";
        };
      }

      {
        mode = "n";
        key = "<leader>e";
        action = "<CMD> :Exp<CR>";
        options = {
          desc = "[E]xplore";
        };
      }
      # Keybinds to make split navigation easier.
      #  Use CTRL+<hjkl> to switch between windows
      #
      #  See `:help wincmd` for a list of all window commands
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w><C-h>";
        options = {
          desc = "Move focus to the left window";
        };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w><C-l>";
        options = {
          desc = "Move focus to the right window";
        };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w><C-j>";
        options = {
          desc = "Move focus to the lower window";
        };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w><C-k>";
        options = {
          desc = "Move focus to the upper window";
        };
      }
    ];

    # https://nix-community.github.io/nixvim/NeovimOptions/autoGroups/index.html
    autoGroups = {
      kickstart-highlight-yank = {
        clear = true;
      };
    };

    # [[ Basic Autocommands ]]
    #  See `:help lua-guide-autocommands`
    # https://nix-community.github.io/nixvim/NeovimOptions/autoCmd/index.html
    autoCmd = [
      # Highlight when yanking (copying) text
      #  Try it with `yap` in normal mode
      #  See `:help vim.highlight.on_yank()`
      {
        event = ["TextYankPost"];
        desc = "Highlight when yanking (copying) text";
        group = "kickstart-highlight-yank";
        callback.__raw = ''
          function()
            vim.highlight.on_yank()
          end
        '';
      }
    ];

    opts = {
        number = true;
        nu = true;
        relativenumber  = true;
        tabstop = 4;
	softtabstop = 4;
	shiftwidth = 4;
	expandtab = true;

        clipboard = "unnamedplus";

	smartindent = true;

	wrap = false;

	swapfile = false;
	backup = false;

    	# Save undo history
	undofile = true;

    	# Set highlight on search
    	hlsearch = false;
    	incsearch = true;
    
    	termguicolors = true;

    	scrolloff = 8;

    	# Decrease update time
    	updatetime = 250;
    	timeoutlen = 300;

    	colorcolumn = "80";

    	# Enable mouse mode
      	mouse = "a";

    	breakindent = true;

    	# Case-insensitive searching UNLESS \C or capital in search
    	ignorecase = true;
    	smartcase = true;

       # Keep signcolumn on by default
       signcolumn = "yes";

    	# Set completeopt to have a better completion experience
    	completeopt = "menuone,noselect";
    	showtabline  = 1;
    };

    plugins = {
      # Adds icons for plugins to utilize in ui
        web-devicons.enable = true;

      # Detect tabstop and shiftwidth automatically
      # https://nix-community.github.io/nixvim/plugins/sleuth/index.html
      sleuth = {
        enable = true;
      };

      # Highlight todo, notes, etc in comments
      # https://nix-community.github.io/nixvim/plugins/todo-comments/index.html
      todo-comments = {
        settings = {
          enable = true;
          signs = true;
        };
      };
    };

    # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extraplugins
    extraPlugins = with pkgs.vimPlugins; [
      nvim-web-devicons 
      (pkgs.vimUtils.buildVimPlugin rec {
        pname = "cozy-bear";
        version = "main";
        src = pkgs.fetchFromGitHub {
          owner = "ebadfd";
          repo = "cozy-bear-nvim";
          rev = version;
          sha256 = "sha256-adAUG8RShe1SJ/VwQ4lS2xFmEuiNjvOL1SPht64eS28=";
          # sha256 = lib.fakeSha256;
        };
      })
    ];

    extraConfigLuaPre = ''
      if vim.g.have_nerd_font then
        require('nvim-web-devicons').setup {}
      end

      require("cozy-bear").setup {
        disable_background = true
      }
      vim.cmd.colorscheme 'cozy-bear'

      function ColorMyPencils(color)
	  color = color or "cozy-bear"
	  vim.cmd.colorscheme(color)

	  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      end

      ColorMyPencils()
    '';
  };
}
