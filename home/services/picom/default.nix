{ config, pkgs, ... }:
{
  services.picom = {
    enable = true;
    experimentalBackends = true;
    vSync = true;
    blur = true;
    shadow = true;
    backend = "glx";
    inactiveOpacity = "0.5";
    shadowExclude = [ "class_g = 'Firefox' && argb" ];
    opacityRule = [
    "100:class_g = 'Polybar'"
    "100:class_g = 'code-oss'"
    "80:class_g = 'Dunst'"
    "80:class_g = 'Signal'"
    "80:class_g = 'Spotify'"
    "80:class_g = 'Skype'"
    "80:class_g = 'Element'"
    "100:class_g = 'i3lock'"
    ];
  };
}
