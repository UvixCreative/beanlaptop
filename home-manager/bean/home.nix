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
'';
  };

  programs.waybar = {
    settings = import ./waybar.nix;
    style = ./waybar.css;
  };

  services.swayidle = {
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -f -l -c 000000" ; }
    ];
    timeouts = [
      { timeout = 60; command = "${pkgs.light}/bin/light -O; ${pkgs.light}/bin/light -S 0"; resumeCommand = "${pkgs.light}/bin/light -I"; } # one minute, dim
      { timeout = 120; command = "${pkgs.sway}/bin/sway output '*' power off"; resumeCommand = "${pkgs.sway}/bin/sway output '*' power on"; } # 2 minutes display off
      { timeout = 125; command = "${pkgs.swaylock}/bin/swaylock -f -l -c 000000" ; } # after 5s display off, lock
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
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  programs.home-manager.enable = true;
  wayland.windowManager.sway.enable = true;
  services.kdeconnect.enable = true;
  programs.swayr.enable = true;
  services.swayidle.enable = true;
  programs.waybar.enable = true;
  gtk.enable = true;
  qt.enable = true;

}
