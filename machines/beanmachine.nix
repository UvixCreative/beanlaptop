# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  # == Boot/kernel modules ==
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" "thunderbolt" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  # == Filesystems ==
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/abf92fde-02ac-4622-9b26-82abf26a9708";
      fsType = "btrfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/527C-91DF";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/root" =
    { device = "/dev/disk/by-uuid/abf92fde-02ac-4622-9b26-82abf26a9708";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/abf92fde-02ac-4622-9b26-82abf26a9708";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/abf92fde-02ac-4622-9b26-82abf26a9708";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/b99395c6-ad51-4c0c-8c3d-0f853ee0c90d"; }
    ];

  # == Networking ==
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "beanmachine";

  # == Bluetooth ==
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # == Platform settings ==
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
