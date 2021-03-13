# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ options, config, pkgs, ... }:

let
  hostName = "nixosYoga";
in {
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ../cache/cachix.nix
      <home-manager/nixos>
    ];
  nixpkgs.config.allowUnfree = true;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.maurice = (import (../home/machines + "/${hostName}.nix") {
    inherit pkgs config;
  });

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  
  networking = {
    inherit hostName;
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.wlp0s26u1u4i2.useDHCP = true;
    firewall = {
      enable = true;
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  services.xserver = {
	enable = true;
	layout = "de";
        desktopManager.session = [{
            name = "home-manager";
            start = ''
              ${pkgs.stdenv.shell} $HOME/.xsession-hm &
              waitPID=$!
              '';
            }];
  	displayManager = {
		lightdm = {
		  enable = true;
		  greeters.enso.enable = true;
		};
		defaultSession = "none+bspwm";
	};
  	windowManager.bspwm.enable = true;
  
	xkbOptions = "caps:escape";
	# Enable touchpad support (enabled default in most desktopManager).
	libinput.enable = true;
	libinput.touchpad.naturalScrolling = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # enable some shells
  programs.fish.enable = true;
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maurice = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     alacritty
     brave
     firefox-bin
     home-manager
     htop
     kitty
     nordic
     vanilla-dmz
     wget
     zafiro-icons
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];

 #environment.shellInit = ''
 #  export SXHKD_SHELL=/bin/sh
 #  export GPG_TTY="$(tty)"
 #  gpg-connect-agent /bye
 #  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
 #	'';
  programs = {
    ssh.startAgent = false;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

