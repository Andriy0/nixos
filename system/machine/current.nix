{ config, pkgs, ... }:

{
  boot = 
    { loader = 
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
      kernelPackages = pkgs.linuxPackages_latest;
      kernelParams = [ "intel_pstate=disable" ];
      kernel.sysctl = 
        { "vm.swappiness" = 10;
        };
      extraModprobeConfig = 
        '' options snd_hda_intel index=1
        '';
    };

    hardware = 
    { 
      enableRedistributableFirmware = true;
      enableAllFirmware = true;
    };

}
