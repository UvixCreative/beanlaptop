{ config, pkgs, ... }:

{
  home.username = "ben";
  home.homeDirectory = "/home/ben";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  programs.swayr.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    config = import ./sway.nix;
  };

  programs.waybar.enable = true;
  programs.waybar.settings = import ./waybar.nix;
}
