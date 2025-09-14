{ config, pkgs, ... }:
{
  # General Wayland configuration
  programs.xwayland.enable = true;
  
  # Core Wayland environment variables
  environment.sessionVariables = {
    # Core Wayland support for applications
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_SESSION_TYPE = "wayland";
    SDL_VIDEODRIVER = "wayland";
    
    # Qt Wayland optimizations
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    
    # Java applications Wayland support
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
