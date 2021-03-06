{ config, pkgs, ... }:

{
  # X11 session settings
  services = 
  {
    gnome3.gnome-keyring.enable = true;
    upower.enable = true;

    dbus = {
      enable = true;
      packages = [ pkgs.gnome3.dconf ];
    };

    xserver = { 
      enable = true;
      layout = "us,ua";
      xkbOptions = "caps:ctrl_modifier,altwin:menu_win";
      videoDrivers = [ "modesetting" ];
      useGlamor = true;

      libinput = { 
        enable = true;
        naturalScrolling = true;
        additionalOptions = '' 
          Option "TappingButtonMap" "lmr"
        '';
      };

      desktopManager = { 
        xterm.enable = false;
      };

      displayManager = { 
        lightdm.enable = true;
        defaultSession = "none+awesome";
      };

      windowManager = { 
        awesome.enable = true;
      };

    };

  };
  
  # Hardware acceleration
  hardware.opengl = { 
    driSupport = true;
    extraPackages = with pkgs; [ 
      intel-compute-runtime
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Screen brightness control utility
  programs.light.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # systemd.services.upower.enable = true;

}
