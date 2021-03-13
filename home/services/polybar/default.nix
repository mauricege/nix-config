{ ... }:
let 
  sysconfig = (import <nixpkgs/nixos> {}).config;

in {
  services.polybar = {
    enable = true;
    config = ./configs + "/${sysconfig.networking.hostName}";
    script = "polybar bar &";
  };
}
