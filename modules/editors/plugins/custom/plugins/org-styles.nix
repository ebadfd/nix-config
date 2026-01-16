{ pkgs, inputs, ... }:
let
  org-bullets-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "org-bullets.nvim";
    src = inputs.org-bullets-nvim;
    doCheck = false;
  };
  org-list-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "org-list.nvim";
    src = inputs.org-list-nvim;
    doCheck = false;
  };
in
{
  programs.nixvim = {
    plugins = {
      headlines.enable = true;
    };
    extraConfigLua = ''
      require("org-bullets").setup()
      require("org-list").setup()
    '';
    extraPlugins = [
      org-bullets-nvim
      org-list-nvim
    ];
  };
}
