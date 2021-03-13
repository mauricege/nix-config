{ config, pkgs, ... }:
{
  services.random-background = {
    enable = true;
    imageDirectory = builtins.toString(./images);
  };
}
