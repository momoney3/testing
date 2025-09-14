{ config, pkgs, ... }:

{
  # Enable Hyprland - Pure Wayland
  programs.hyprland = {
    enable = true;
  };

  # Essential Wayland/Hyprland packages
  environment.systemPackages = with pkgs; [
    # Core Hyprland ecosystem
    hyprland
    hyprpaper          # Wallpaper utility
    hyprlock           # Screen locker
    hypridle           # Idle daemon
    hyprpicker         # Color picker
    hyprcursor
    
    # Wayland utilities
    waybar             # Status bar
    wofi               # Application launcher
    swaynotificationcenter  # Notification daemon
    grim               # Screenshot tool
    slurp              # Screen area selection
    
    # File manager and utilities
    xfce.thunar
    xfce.thunar-volman # Volume management for thunar
    
    # Image tools for wallpaper generation
    imagemagick
  ];

  # Security and authentication
  security = {
    polkit.enable = true;
    pam.services.hyprlock = {}; # Enable PAM for hyprlock
  };

  # Enable required services
  services = {
    
    # Thumbnail generation for file managers
    tumbler.enable = true;
  };

  # Environment variables for Pure Wayland
  environment.sessionVariables = {
    # AMD-specific variables (from your current config)
    LIBVA_DRIVER_NAME = "radeonsi";
    
    # Hyprland-specific
    WLR_NO_HARDWARE_CURSORS = "1"; # If you have cursor issues
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    
    # Disable X11 fallbacks
    WAYLAND_DISPLAY = "wayland-1";
    GDK_BACKEND = "wayland";
    CLUTTER_BACKEND = "wayland";
  };
}
