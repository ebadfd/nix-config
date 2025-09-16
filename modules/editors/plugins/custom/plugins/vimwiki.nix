{
  # Personal Wiki for Vim.
  # https://nix-community.github.io/nixvim/plugins/vimwiki.html
  programs.nixvim = {
    plugins.vimwiki = {
      enable = true;
    };

  };
}
