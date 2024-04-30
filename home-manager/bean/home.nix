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
    package = pkgs.swayfx;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
    config = import ./sway.nix;
    extraConfig = ''
title_align center
corner_radius 10
smart_corner_radius enable
default_dim_inactive 0.3
'';
  };

  programs.waybar = {
    enable = true;
    settings = import ./waybar.nix;
    style = ./waybar.css;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style.name = "adwaita-dark";
  };
}
