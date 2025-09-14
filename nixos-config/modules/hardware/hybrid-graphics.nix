{ config, pkgs, ... }:
{
  # AMD + NVIDIA hybrid setup for latest kernel
  boot.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [ 
    # "amdgpu.runpm=0"
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
  ];
  boot.blacklistedKernelModules = [ "nouveau" ];

  # Wayland-optimized environment (AMD primary only)
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
    # Removed NVIDIA variables - these were forcing GNOME to use NVIDIA
    # GBM_BACKEND = "nvidia-drm";
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  # NVIDIA configuration - latest drivers, power efficient
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    
    open = true;  # Latest open-source kernel modules
    nvidiaSettings = false;
    
    prime = {
      # Offload mode - NVIDIA sleeps, AMD handles desktop
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      sync.enable = false;
      
      amdgpuBusId = "PCI:6:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # Essential GPU tools
  environment.systemPackages = with pkgs; [
    config.boot.kernelPackages.nvidiaPackages.latest.bin  # nvidia-smi
    nvtopPackages.nvidia
    radeontop
    glxinfo
  ];

  # Container support
  # hardware.nvidia-container-toolkit = {
  #   enable = true;
  #   suppressNvidiaDriverAssertion = true;
  # };

  # Minimal X11 for driver registration (required for detection)
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" "nvidia" ];
  };
}
