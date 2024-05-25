# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  # == NixOS things ==
  imports =
    [
      ./home-manager/home-manager.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # == Basic system/hardware config ==

  # ++ Audio and pipewire ++
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # ++ Graphics ++
  # Enable and configure openGL
  hardware.opengl = {
    enable = true;
    driSupport.enable = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
      amdvlk
    ];
  };

  # ++ Power management ++
  # Power button config
  services.logind = {
    powerKey = "suspend-then-hibernate";
    powerKeyLongPress = "poweroff";
    lidSwitch = "suspend-then-hibernate"; # Default setting, just added for documentation
    lidSwitchDocked = "suspend-then-hibernate";
    lidSwitchExternalPower = "suspend";
  };

  # Sleep settings
  systemd.sleep.extraConfig = ''
HibernateDelaySec=15m
SuspendState=mem
'';

  # ++ Boot and networking ++
  # systemd-boot bootloader
  boot.loader.systemd-boot.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # ++ Locale ++
  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # == Desktop/WM config ==

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable SDDM and the KDE Plasma Desktop Environment
  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
  };
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable Sway WM
  programs.sway = {
    enable = true;
    wrapperFeatures = {
      gtk = true;
      base = true;
    };
  };

  # Program to configure screen brightness
  programs.light.enable = true;

  # == User accounts and packages ==

  # ++ Users ++

  users.users.bean = {
    isNormalUser = true;
    description = "Ben Rankin";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    packages = with pkgs; [
    ];
    shell = pkgs.fish;
  };

  # ++ Packages ++

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    chromium = {
      enableWideVine = true; # Enable DRM in Chromium
    };
  };

  # System nixos packages
  programs.kdeconnect.enable = true;
  programs.fish.enable = true;

  # System nixpkgs packages
  environment.systemPackages = with pkgs; [
     firefox
     kitty
     discord
     ardour
     libreoffice
     plasma-browser-integration
     git
     swayr
     nmap
     waybar
     slurp
     grim
     wl-clipboard
     font-awesome
     wofi
     swaynotificationcenter
     pavucontrol
     signal-desktop
     davinci-resolve
     rawtherapee
     nextcloud-client
     calibre
     chromium
     prismlauncher
     vlc
     lsp-plugins
     calf
     logseq
     kdenlive
     inkscape
     busybox
     btop
  ];

  # Flatpak packages
  services.flatpak.enable = true;
  services.flatpak.packages = [
    "app.bluebubbles.BlueBubbles"
    "com.valvesoftware.Steam"
  ];

  # Steam is installed as flatpak, so keep nixos steam disabled, but open remoteplay firewall
  programs.steam = {
    remotePlay.openFirewall = true;
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # == Services ==

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Polkit
  security.polkit.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 1803 ];
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 1803 ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # == State version thing don't worry about it ==

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
