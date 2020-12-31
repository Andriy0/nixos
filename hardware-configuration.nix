# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.extraModprobeConfig = 
    '' options snd_hda_intel index=1
    '';
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  
  # Powersaving
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "intel_pstate=disable" ];
  services.tlp = 
    { enable = true;
	  settings = 
        { CPU_SCALING_GOVERNOR_ON_AC = "ondemand";
		  CPU_SCALING_GOVERNOR_ON_BAT = "ondemand";

		  CPU_SCALING_MIN_FREQ_ON_AC = 500000;
		  CPU_SCALING_MAX_FREQ_ON_AC = 1600000;
		  CPU_SCALING_MIN_FREQ_ON_BAT = 500000;
		  CPU_SCALING_MAX_FREQ_ON_BAT = 1600000;
        };
    };

  # Filesystems
  fileSystems."/" =
    { device = "/dev/sda6";
      fsType = "btrfs";
      options = [ "rw,noatime,ssd,compress=zstd,space_cache,commit=120,subvol=@" ];
    };

  fileSystems."/home" =
    { device = "/dev/sda6";
      fsType = "btrfs";
      options = [ "rw,noatime,ssd,compress=zstd,space_cache,commit=120,subvol=@home" ];
    };

  fileSystems."/.snapshots" =
    { device = "/dev/sda6";
      fsType = "btrfs";
      options = [ "rw,noatime,ssd,compress=zstd,space_cache,commit=120,subvol=@snapshots" ];
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/061D-C556";
      fsType = "vfat";
      options = [ "rw,noatime" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/ad752a2b-9336-4b90-b04f-b9e9db4001f8"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
