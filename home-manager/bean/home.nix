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
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
    config = import ./sway.nix;
    extraConfig = ''
title_align center
bindgesture swipe:3:right workspace next
bindgesture swipe:3:left workspace prev
bindgesture swipe:3:down exec light -U 10
bindgesture swipe:3:up exec light -A 10
bindgesture swipe:4:up focus up
bindgesture swipe:4:down focus down
bindgesture swipe:4:right focus right
bindgesture swipe:4:left focus left
bindgesture pinch:2:inward+up move up
bindgesture pinch:2:inward+down move down
bindgesture pinch:2:inward+left move left
bindgesture pinch:2:inward+right move right
'';
  };

  programs.waybar = {
    settings = import ./waybar.nix;
    style = ./waybar.css;
  };

  gtk = {
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };

  qt = {
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  programs.home-manager.enable = true;
  wayland.windowManager.sway.enable = true;
  services.kdeconnect.enable = true;
  programs.swayr.enable = true;
  programs.waybar.enable = true;
  gtk.enable = true;
  qt.enable = true;

}
