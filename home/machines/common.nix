{ config, pkgs, ... }:
{  
  programs.home-manager.enable = true;

  imports = [
    # ../programs/neovim
    # ../services/screenlocker.nix
    # ../services/picom
    # ../services/polybar
    ../programs/rofi
    ../backgrounds
    ../programs/zsh
    # ../services/bspwm
  ];

  home.file.".config/nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
    '';

  xresources.extraConfig = builtins.readFile (
    pkgs.fetchFromGitHub {
      owner = "arcticicestudio";
      repo = "nord-xresources";
      rev = "develop";
      sha256 = "1labc69iis5nx7cz88lkp0jsm5aq3ywih15g1fhc4814hv0x0ckf";
    } + "/src/nord" );

  xsession.scriptPath = ".xsession-hm";


  programs.git = {
    enable = true;
    userName = "Maurice Gerczuk";
    userEmail = "15089301+mauricege@users.noreply.github.com";

  };



  home.packages = with pkgs; [
    spotify-tui
    bitwarden-cli
  ];
}
