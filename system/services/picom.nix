{ config, pkgs, ... }:

{
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

}
