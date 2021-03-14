{ config, pkgs, hostName ? "unknown", ... }:
{  
  programs.home-manager.enable = true;

  imports = [
    ./common.nix
  ];

}
