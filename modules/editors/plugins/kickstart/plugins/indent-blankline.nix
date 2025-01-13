{
  programs.nixvim = {
    plugins.rainbow-delimiters.enable = true;
    # Add indentation guides even on blank lines
    # For configuration see `:help ibl`
    # https://nix-community.github.io/nixvim/plugins/indent-blankline/index.html
    plugins.indent-blankline = {
      enable = true;
      settings = {
        indent = {
          char = "┊";
        };
        scope.char = "│";
      };
    };

    plugins.mini = {
      enable = true;

      mockDevIcons = true;
      modules.icons = { };
    };
  };
}
