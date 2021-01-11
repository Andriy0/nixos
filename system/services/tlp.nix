{ config, pkgs, ... }:

{
  services.tlp = 
  {
    enable = true;
    settings = 
    {
      CPU_SCALING_GOVERNOR_ON_AC = "ondemand";
      
      CPU_SCALING_GOVERNOR_ON_BAT = "ondemand";
      
      CPU_SCALING_MIN_FREQ_ON_AC = 500000;
      # CPU_SCALING_MAX_FREQ_ON_AC = 1600000;
      CPU_SCALING_MAX_FREQ_ON_AC = 2100000;
      
      CPU_SCALING_MIN_FREQ_ON_BAT = 500000;
      # CPU_SCALING_MAX_FREQ_ON_BAT = 1600000;
      CPU_SCALING_MAX_FREQ_ON_BAT = 2100000;
    };
  };

}
