{ config, pkgs, ... }:

{
  home.username = "bean";
  home.homeDirectory = "/home/bean";

  home.stateVersion = "24.05";

  home.file.".config/sway/wallpaper.jpg" = {
    enable = true;
    source = ./wallpaper.jpg;
  };

  programs.home-manager.enable = true;
  programs.swayr.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    config = import ./sway.nix;
  };

  programs.waybar = {
    enable = true;
    settings = import ./waybar.nix;
    style = ./waybar.css;
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
