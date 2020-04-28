# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstable-small = import <unstable-small>{
    config.allowUnfree = true;
  };
  nixpkgs-unstable = import <nixpkgs>{
    config.allowUnfree = true;
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = unstable-small.linuxPackages;
  # boot.extraModulePackages = with config.boot.kernelPackages; [ asus-wmi-sensors ];
  # # The above is still broken :'(

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;
  # systemd.network.enable = true; # still seems broken :'(

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  nixpkgs.config = {
    packageOverrides = pkgs: {
      lxd = unstable-small.lxd;
    };
    allowUnfree = true;
    pulseaudio = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    unstable-small.neovim unstable-small.lxd pciutils git stow gnumake unstable-small.zsh unstable-small.tmux # default installation
    microcodeAmd # for amd microcode
    unstable-small.cudatoolkit unstable-small.libGLU # for nvidia gpu
    nixos-generators # for creating lxc container
    jdk # java 8
    unzip # random utils
    htop
    nginx
    netcat
    docker
    file
    usbutils
    home-manager
    samba
    unstable-small.lm_sensors
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.forwardX11 = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 80 443 8000 445 139 8123 9000 9009 ];
  networking.firewall.allowedUDPPorts = [ 137 138 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    deviceSection = ''
      Option "Coolbits" "12"
    '';
    # extraConfig = ''

    #   Section "Monitor"
    #       Identifier     "Monitor1"
    #       VendorName     "Unknown"
    #       ModelName      "CRT-0"
    #       HorizSync       28.0 - 81.0
    #       VertRefresh     48.0 - 75.0
    #   EndSection

    #   Section "Device"
    #       Identifier     "Device1"
    #       Driver         "nvidia"
    #       VendorName     "NVIDIA Corporation"
    #       BoardName      "GeForce GTX 1080"
    #       BusID          "PCI:6:0:0"
    #       Option "Coolbits" "12"
    #   EndSection

    #   Section "Screen"
    #       Identifier     "Screen1"
    #       Device         "Device1"
    #       Monitor        "Monitor1"
    #       DefaultDepth    24
    #       Option         "ConnectedMonitor" "CRT"
    #       Option         "Coolbits" "5"
    #       Option         "TwinView" "0"
    #       Option         "TwinViewXineramaInfoOrder" "CRT-0"
    #       Option         "metamodes" "nvidia-auto-select +0+0"
    #       SubSection     "Display"
    #           Depth       24
    #       EndSubSection
    #       Option "Coolbits" "12"
    #   EndSection
    # '';
  };

  services.samba = {
    enable = true;
    securityType = "user";
    extraConfig = ''
    #  workgroup = WORKGROUP
    #  server string = smbnix
    #  netbios name = smbnix
     security = user
    #  #use sendfile = yes
    #  #max protocol = smb2
    #  hosts allow = 192.168.0  localhost
    #  hosts deny = 0.0.0.0/0
    #  guest account = nobody
    #  map to guest = bad user
    '';
    shares = {
      public = {
        path = "/home/addison/";
        browseable = "yes";
        "read only" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "addison";
        # "force group" = "groupname";
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.addison = {
    isNormalUser = true;
    home = "/home/addison";
    extraGroups = [ "wheel" "lxd" "networkmanager" "docker" "audio" ];
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/psF8VxWFoLvLghO8eK3J/cIXWWZejLKT2To6UC6kqOpkM3/JHN1gkpl7YOYVn3uR5HLmH3ya0oAfzBn/m7NUDTGHFNzjfRVUqzuKlGmmxW4ePbjkn+kJuRtUbtB0atkIFg80Zd3ozyBCLo+dhN/Rd8IUDegeFtnMugFPmowpHLYemN8IH8r5o56FURQNW9DUGxU42xh0c764U45yQCvql6hnF5W/EiVm4QVo/H0IEJyMrGJ/lkS6ChdYXCnh6n16Z2S2OUS4y7ydTo1YyP36H5tDkJwMkJ+clyDDkAhDUGBzvKsCCPzY0dJmbhLeOobXi3dusmLt4K6gPxl45o/ft3LMXHFoB/nKoKAbtC6HKKcyfL3wGOQJrzeiuZJHcLUNmlV66L013/+dX/AFEBDI+dS4xXfhZBqTWTC1V4M6MmFvS0mh4kD5NBf34ZSBwhvPwyZzdnx3wU61wA9PXQgEHx8xh5hSp9VuRhHEn7zERMwmGKSizFJ6foEyoncJV1vQGZ6UZHromNCprm+j8qwVb7u3nihaIO5bA5p5xv14goz+O/DpG6Kp/yjpvW3+PHdkirUwPwzshq6t3ITn+Tzi8jAZ1D1f4na+tsgEp2tJ/BLrvci+RFAxiXBfKlUZtCU7utd57K0S1fZbuT83GB+MHf37LcwT0FjnjCy4pxfaXQ==" ];
    shell = pkgs.zsh;
  };

  users.groups = {
    andi = {
      members = ["andi"];
      gid = 1001;
    };
    harry = {
      members = ["harry"];
      gid = 1002;
    };
  };

  users.users.andi = {
    group = "andi";
    isNormalUser = true;
    home = "/home/andi";
    extraGroups = [];
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDrKZTu6rI9VlceMQImWIXhXSeMekzpKgftaP3FD5S33rdh8bZVLzKd/FQS182wEoA8lRO+IMoQHDNvxfl6DBpto4537EDDVPzSAOwJWh7tzM055dzkr2Oq8Hvoppx1pFqED03dGFgwV8swAVpmSGjTqzzl0LIHDq/XR8LqkkqBrpcCbm3nKNR6sKg4Fje70v3PD/DGrKTX12b9WyeeVXm7VRFWFs+rXFKgdqjBE8KoB2lveukxh4NxbEMfJHXA56XycRHJaeNk4AJm9AsdXHNrsc2BboWvPZi6g0ITdNLkZQhcIJ2N0EcaJShSjaHgSuM5E6BmYoDJ6d5h7eKCAo+d andigu@Andis-MacBook-Pro.local" ];
    shell = pkgs.bash;
  };

  users.users.harry = {
    group = "harry";
    isNormalUser = true;
    home = "/home/harry";
    extraGroups = [];
    shell = pkgs.bash;
  };

  users.users.root = {
    subUidRanges = [
      { startUid = 1000000; count = 65536; }
    ];
    subGidRanges = [
      { startGid = 1000000; count = 65536; }
    ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

  virtualisation.lxd.enable = true;
  virtualisation.docker.enable = true;

  # Nginx configuration
  services.nginx = {
    enable = true;

    # # recommendedProxySettings = true;
    # # recommendedTlsSettings = true;
    # virtualHosts."jupyter.addcnin.blue" = {
    #   enableACME = true;
    #   forceSSL = true;
    #   root = "/var/www/test";
    # };

    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    # other Nginx options
    virtualHosts."jupyter.addcnin.blue" =  {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://10.48.159.105:8000";
        proxyWebsockets = true; # needed if you need to use WebSocket
        extraConfig =
          # required when the target is also TLS server with multiple hosts
          "proxy_ssl_server_name on;" +
          # required when the server wants to use HTTP Authentication
          "proxy_pass_header Authorization;"
          ;
      };
    };
    virtualHosts."cs161.addcnin.blue" =  {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8080";
        extraConfig =
          # required when the target is also TLS server with multiple hosts
          "proxy_ssl_server_name on;" +
          # required when the server wants to use HTTP Authentication
          "proxy_pass_header Authorization;"
          ;
      };
    };

  };

  security.acme.certs."jupyter.addcnin.blue" = {
    email = "addison95132@gmail.com";
  };
  # security.acme.acceptTerms = true;

  networking.nat.enable = true;
  networking.nat.internalInterfaces = ["ve-+"];
  networking.nat.externalInterface = "enp4s0";

  # containers
  # containers.addison = {
  #   autoStart = true;

  #   privateNetwork = true;
  #   hostAddress = "192.168.100.1";
  #   localAddress = "192.168.100.2";

  #   bindMounts = {
  #     "/home/addison" = { hostPath = "/mnt/addison"; isReadOnly = false; };
  #     "/dev/bus/usb" = { hostPath = "/dev/bus/usb"; isReadOnly = false; };
  #   };

  #   config =
  #   { config, pkgs, ... }:
  #   let
  #     unstable-small = import <unstable-small>{};
  #     nixpkgs-unstable = import <nixpkgs>{
  #       config.allowUnfree = true;
  #     };
  #   in
  #   {
  #     environment.systemPackages = with pkgs; [
  #       unstable-small.neovim unstable-small.lxd git stow gnumake unstable-small.zsh unstable-small.tmux htop # default installation
  #       unstable-small.elixir
  #       docker
  #       ruby_2_5
  #       openssl
  #       python3 python37Packages.pip python37Packages.setuptools
  #       gcc
  #       file
  #       binutils
  #       zlib
  #     ];

  #     users.users.addison = {
  #       isNormalUser = true;
  #       home = "/home/addison";
  #       extraGroups = ["wheel" "lxd" "networkmanager"];
  #       openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/psF8VxWFoLvLghO8eK3J/cIXWWZejLKT2To6UC6kqOpkM3/JHN1gkpl7YOYVn3uR5HLmH3ya0oAfzBn/m7NUDTGHFNzjfRVUqzuKlGmmxW4ePbjkn+kJuRtUbtB0atkIFg80Zd3ozyBCLo+dhN/Rd8IUDegeFtnMugFPmowpHLYemN8IH8r5o56FURQNW9DUGxU42xh0c764U45yQCvql6hnF5W/EiVm4QVo/H0IEJyMrGJ/lkS6ChdYXCnh6n16Z2S2OUS4y7ydTo1YyP36H5tDkJwMkJ+clyDDkAhDUGBzvKsCCPzY0dJmbhLeOobXi3dusmLt4K6gPxl45o/ft3LMXHFoB/nKoKAbtC6HKKcyfL3wGOQJrzeiuZJHcLUNmlV66L013/+dX/AFEBDI+dS4xXfhZBqTWTC1V4M6MmFvS0mh4kD5NBf34ZSBwhvPwyZzdnx3wU61wA9PXQgEHx8xh5hSp9VuRhHEn7zERMwmGKSizFJ6foEyoncJV1vQGZ6UZHromNCprm+j8qwVb7u3nihaIO5bA5p5xv14goz+O/DpG6Kp/yjpvW3+PHdkirUwPwzshq6t3ITn+Tzi8jAZ1D1f4na+tsgEp2tJ/BLrvci+RFAxiXBfKlUZtCU7utd57K0S1fZbuT83GB+MHf37LcwT0FjnjCy4pxfaXQ==" ];
  #       shell = pkgs.zsh;
  #     };

  #     programs.zsh.enable = true;

  #     virtualisation.docker.enable = true;
  #     services.openssh.enable = true;
  #     services.openssh.forwardX11 = true;
  #   };
  # };
}
