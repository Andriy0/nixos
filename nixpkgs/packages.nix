pkgs: withGUI: with pkgs; [
  # these files are meant to be installed in all scenarios
  emacs
  acpi feh starship
  nodejs
  ccls clang clang-tools rnix-lsp

# intended to be installed with an X11 or Wayland session
] ++ pkgs.lib.optionals withGUI [
  gimp alacritty kitty firefox nitrogen
  lxappearance volumeicon xfce.thunar
  arc-theme papirus-icon-theme

# lua stuff
] ++ ( with lua53Packages; [
  lua lua-lsp 
] )
