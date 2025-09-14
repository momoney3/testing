{ config, pkgs, ... }:

{
  # Install Tokyo Night theme and theming tools
  environment.systemPackages = with pkgs; [
    # Tokyo Night GTK theme
    tokyo-night-gtk
    
    # Icon themes that work well with Tokyo Night
    papirus-icon-theme
    bibata-cursors
    
    # Easy GUI theme configuration
    lxappearance    # GTK theme picker - just point and click!
    # kvantum
    
    # Optional: if you want to tweak advanced settings
    dconf-editor

    libsForQt5.qt5ct
   kdePackages.qt6ct
  ];

  # Enable dconf for theme settings storage
  programs.dconf.enable = true;
}
