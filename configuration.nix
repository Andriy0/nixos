# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader = 
    { efi = 
        { # canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/efi";
        };
      grub = 
        { efiSupport = true;
          efiInstallAsRemovable = true;
          device = "nodev";
        };

    };

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Kiev";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.useDHCP = false;
  # networking.interfaces.enp1s0.useDHCP = true;
  # networking.interfaces.wlo1.useDHCP = true;

  networking = 
    { hostName = "nixos";
      defaultGateway = "192.168.1.1";
      nameservers = [ "8.8.8.8" ];
      firewall.enable = true;
      # networkmanager.enable = true;
      wireless = 
        { enable = true;
          networks = 
            { "UKrtelecom_JZJ87Q" = 
                { pskRaw = "be9f9dc510f25edb3e12259a2eeb0432277e7cbb74b6b0d0677fde9c4ad0b78d";
                };
            };
        };
    };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };
  
  # X11
  services.xserver = 
    { enable = true;
      layout = "us,ua";
      xkbOptions = "caps:escape_shifted_capslock,altwin:menu_win,grp:alt_shift_toggle";
      videoDrivers = [ "modesetting" ];
      useGlamor = true;
      libinput = 
        { enable = true;
          naturalScrolling = true;
          additionalOptions = 
            '' Option "TappingButtonMap" "lmr"
            '';
        };
      desktopManager = 
        { xterm.enable = false;
        };
      displayManager = 
        { lightdm.enable = true;
          defaultSession = "none+awesome";
        };
      windowManager = 
        { awesome.enable = true;
        };
  };

  services.picom = 
    { enable = true;
      fade = false;
      inactiveOpacity = 1.0;
      shadow = false;
      backend = "glx";
      vSync = true;
      settings = 
        { use-damage = true;
          glx-no-stencil = true;
          glx-no-rebind-pixmap = true;
          xrendr-sync-fence = true;
        };
    };

  services.cron = 
    { enable = true;
      systemCronJobs = 
        [ "@reboot  root  sysctl dev.i915.perf_stream_paranoid=0"
        ];
    };
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  
  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.groups = 
    { andriy.gid = 1000;
    };

  users.users = 
    { andriy = 
        { isNormalUser = true;
          home = "/home/andriy";
          description = "Andrii";
          uid = 1000;
          group = "andriy";
          extraGroups = [ "users" "wheel" "audio" "video" "networkmanager" ];
          shell = pkgs.fish;
        };
    };

  programs.fish.enable = true;

  boot.kernel.sysctl = 
    { "vm.swappiness" = 10;
      "dev.i915.perf_stream_paranoid" = 0;
    };

  nixpkgs.config.packageOverrides = pkgs: 
    { vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    };

  hardware.opengl = 
    { driSupport = true;
      extraPackages = with pkgs; 
        [ intel-compute-runtime
          intel-media-driver
          vaapiIntel
          vaapiVdpau
          libvdpau-va-gl
        ];
    };

  nixpkgs.config = 
    { allowUnfree = true;
    };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; 
    [ wget vim neovim git xclip alacritty nodejs arandr xorg.xev acpi firefox nitrogen 
      networkmanagerapplet volumeicon lxappearance arc-theme papirus-icon-theme pcmanfm
      clinfo vulkan-tools light (chromium.override { enableVaapi = true; }) libva-utils
      flameshot starship
    ];
  
  fonts.fonts = with pkgs; 
    [ (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Mononoki" ]; })
    ];

  documentation = 
    { enable = true;
      man.enable = true;
      dev.enable = true;
    };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  security.doas = 
    { enable = true;
      extraRules = 
        [ { users = [ "andriy" ]; noPass = true; keepEnv = true; }
        ];
    };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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

