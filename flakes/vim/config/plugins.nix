{ pkgs, ... }:

let
  vimPlugins = with pkgs.vimPlugins; [
    telescope-nvim
    telescope-z-nvim
    telescope-lsp-handlers-nvim
    colorizer
    vim-tmux-navigator
    vim-fugitive
    fugitive-gitlab-vim
    vim-signify
    robotframework-vim
    nvim-coverage
    plenary-nvim
  ];
in {
  extraPlugins = vimPlugins;
}
