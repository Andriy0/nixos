{ config, pkgs, ... }:

{
  services.cron = 
    { enable = true;
      systemCronJobs = 
        [ "@reboot  root  sysctl dev.i915.perf_stream_paranoid=0"
        ];
    };

}
