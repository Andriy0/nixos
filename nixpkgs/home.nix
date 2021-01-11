{ config, lib, pkgs, ... }:

let
  vimsettings = import ./vim.nix;
  packages = import ./packages.nix;
  withGUI = (builtins.pathExists ./withGUI && import ./withGUI);
  inherit (lib) mkIf;
in
{
  # Home-manager
  programs.home-manager.enable = true;
  home.username = "andriy";
  home.homeDirectory = "/home/andriy";

  # My packages
  home.packages = packages pkgs withGUI;

  # Neovim
  home.file.".config/nvim/coc-settings.json".source = ./coc-settings.json;
  programs.neovim = vimsettings pkgs;

  # Lockscreen
  # services.screen-locker = {
  #   enable = true;
  #   inactiveInterval = 30;
  #   lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dim";
  #   };
}
