{ config, pkgs, lib, ... }:

{
  imports = [ ../hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.opengl.enable = true;
  hardware.facetimehd.enable = true;
  hardware.enableAllFirmware = true;

  boot = {
    kernelModules = [ "v4l2loopback" "usb_storage" "usbhid" "xhci_pci" "ehci_pci" ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
      "zswap.enabled=1"
      "zswap.compressor=lz4"
      "zswap.max_pool_percent=20"
      "usbcore.autosuspend=-1"
    ];
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;
}
