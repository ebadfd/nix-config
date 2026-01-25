{ pkgs, inputs, ... }:
let
  org-roam-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "org-roam.nvim";
    src = inputs.org-roam-nvim;
    doCheck = false;
  };
in
{
  programs.nixvim = {
    extraConfigLua = ''
      require("org-roam").setup({
        directory = "~/Notes",
      })
    '';
    extraPlugins = [ org-roam-nvim ];
  };
}
