{ config, pkgs, ... }:
{
  # GNOME with Wayland optimizations
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
    autoSuspend = false;  # Better for docking
  };
  
  services.desktopManager.gnome.enable = true;
  programs.dconf.enable = true;

  # Clean GNOME setup
  services.gnome = {
    games.enable = false;
    gnome-keyring.enable = true;
    gnome-online-accounts.enable = false;
  };

  # Essential GNOME packages only
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-extension-manager
    
    # Essential extensions
    gnomeExtensions.blur-my-shell
    gnomeExtensions.space-bar
    gnomeExtensions.tactile
    gnomeExtensions.just-perfection
    
    # Essential apps
    file-roller
    evince
    eog
  ];

  # Remove GNOME bloat
  environment.gnome.excludePackages = with pkgs; [
    gnome-calendar gnome-contacts gnome-music gnome-photos
    gnome-maps gnome-weather gnome-clocks gnome-boxes
    gnome-characters gnome-font-viewer gnome-logs gnome-tour
    gnome-themes-extra gnome-user-docs gnome-initial-setup
    gnome-software yelp epiphany simple-scan geary
    evolution-data-server gnome-online-accounts
  ];

  # Essential services (portal handled by existing portal.nix)
  security.pam.services.gdm.enableGnomeKeyring = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}


