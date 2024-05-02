{ config, pkgs, ... }:

{
  home.username = "bean";
  home.homeDirectory = "/home/bean";

  home.stateVersion = "24.05";

  home.file.".config/sway/wallpaper.jpg" = {
    enable = true;
    source = ./wallpaper.jpg;
  };

  wayland.windowManager.sway = {
    package = pkgs.swayfx;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
    config = import ./sway.nix;
    extraConfig = ''
title_align center
corner_radius 15
smart_corner_radius enable
default_dim_inactive 0.1
'';
  };

  programs.waybar = {
    settings = import ./waybar.nix;
    style = ./waybar.css;
  };

  services.swayidle = {
    events = [
      { event = "lock"; command = "swaylock -f -l -c 000000" ; }
      { event = "before-sleep"; command = "swaylock -f -l -c 000000" ; }
    ];
    timeouts = [
      { timeout = 60; command = "swaylock -f -l -c 000000" ; } # one minute
      { timeout = 600; command = "systemctl suspend" ; } # ten minutes
    ];
  };

  gtk = {
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };

  qt = {
    platformTheme = "gnome";
    style.name = "adwaita-dark";
  };

  wayland.windowManager.sway.enable = true;
  programs.home-manager.enable = true;
  programs.swayr.enable = true;
  services.swayidle.enable = true;
  programs.waybar.enable = true;
  gtk.enable = true;
  qt.enable = true;

}
