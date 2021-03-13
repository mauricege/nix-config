{ config, pkgs, ... }:
{
  services.screen-locker = {
    enable = true;
    lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen -l";
  };
  home.packages = [
    pkgs.betterlockscreen
  ];
}
