# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

let
  customFonts = pkgs.nerdfonts.override {
    fonts = [
      # "JetBrainsMono"
      # "Iosevka"
      "Mononoki"
    ];
  };

  myfonts = pkgs.callPackage fonts/default.nix { inherit pkgs; };
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Machine-specific configuration
      ./machine/current.nix
      # Window manager 
      ./wm/awesome.nix
      # System services
      ./services/tlp.nix
      ./services/cron.nix
      ./services/picom.nix
    ];


    networking = 
    { 
      hostName = "nixos";
      defaultGateway = "192.168.1.1";
      nameservers = [ "8.8.8.8" ];
      firewall.enable = true;
      # networkmanager.enable = true;
      wireless = 
      { 
        enable = true;
        networks = 
        { 
          "UKrtelecom_JZJ87Q" = 
          { 
            pskRaw = "be9f9dc510f25edb3e12259a2eeb0432277e7cbb74b6b0d0677fde9c4ad0b78d";
          };
        };
      };
    };


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Kiev";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable           = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable Docker support.
  # virtualisation = {
  #   docker = {
  #     enable = true;
  #   };
  # };

  # Enable sound.
  sound = {
    enable = true;
    # mediaKeys.enable = true;
  };
  # hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;

    # Enable CUPS to print documents.
    # printing.enable = true;
  };

  # Making fonts accessible to applications.
  fonts.fonts = with pkgs; [
    customFonts
    font-awesome-ttf
    cantarell-fonts
    # myfonts.icomoon-feather
  ];

  # programs.fish.enable = true;

  # Groups
  users.groups = { andriy.gid = 1000; };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andriy = {
    isNormalUser = true;
    home = "/home/andriy";
    description = "Andrii";
    uid = 1000;
    group = "andriy";
    extraGroups  = [ "users" "audio" "video" "networkmanager" "wheel" ]; # wheel for ‘sudo’.
    # shell        = pkgs.fish;
  };

  # Doas, analog of sudo
  security.doas = 
  { 
    enable = true;
    extraRules = 
    [ 
      { users = [ "andriy" ]; noPass = true; keepEnv = true; }
    ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Nix daemon config
  nix = {
    # Automate `nix-store --optimise`
    # autoOptimiseStore = true;

    # Automate garbage collection
    # gc = {
    #   automatic = true;
    #   dates     = "weekly";
    #   options   = "--delete-older-than 7d";
    # };

    # Avoid unwanted garbage collection when using nix-direnv
    # extraOptions = ''
    #   keep-outputs     = true
    #   keep-derivations = true
    # '';

    # Required by Cachix to be used as non-root user
    # trustedUsers = [ "root" "gvolpe" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

