# { config, pkgs, ... }:
# {
#   # Latest OpenGL/Vulkan drivers for hybrid setup
#   hardware.graphics = {
#     enable = true;
#     enable32Bit = true;
#
#     # Latest AMD + NVIDIA packages
#     extraPackages = with pkgs; [
#       amdvlk                 # Latest AMD Vulkan driver
#       nvidia-vaapi-driver    # Latest NVIDIA video acceleration
#       vaapiVdpau            # Video acceleration
#       libvdpau-va-gl        # Additional video acceleration
#     ];
#
#     extraPackages32 = with pkgs.driversi686Linux; [
#       amdvlk
#     ];
#   };
# }

{ config, pkgs, ... }:
{
  # Latest graphics drivers for hybrid AMD/NVIDIA setup
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    
    # Latest drivers for both GPUs
    extraPackages = with pkgs; [
      amdvlk                 # Latest AMD Vulkan
      nvidia-vaapi-driver    # NVIDIA video acceleration
      vaapiVdpau            # Cross-platform video acceleration
      libvdpau-va-gl        # Additional video acceleration
    ];
    
    extraPackages32 = with pkgs.driversi686Linux; [
      amdvlk
    ];
  };
}
