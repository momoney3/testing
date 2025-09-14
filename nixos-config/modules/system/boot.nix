{ config, pkgs, ... }:
{
  boot = {
    # Modern bootloader
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Latest kernel with latest drivers (2024)
    kernelPackages = pkgs.linuxPackages_latest;

    # Optimized kernel parameters for AMD + modern power scaling
    kernelParams = [
      "amd_pstate=guided"     # Latest AMD power scaling
      "amdgpu.dc=1"          # Display core support
      "amdgpu.dpm=1"         # Dynamic power management
    ];

    # Early GPU loading
    initrd = {
      kernelModules = [ "amdgpu" ];
      luks.devices."luks-39ce179a-147d-4db7-873d-0cb29a14ee46".device = "/dev/disk/by-uuid/39ce179a-147d-4db7-873d-0cb29a14ee46";
    };
  };

  # Latest firmware and microcode
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
}
