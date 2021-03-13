{ config, pkgs, ... }:
let
  pkgs = import <nixpkgs> { overlays = [ (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    })) ];};
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias =true;
    package = pkgs.neovim-nightly;
    plugins = with pkgs.vimPlugins; [
    vim-nix
    yankring
    vim-startify
    vim-airline
    ];
  };
}
