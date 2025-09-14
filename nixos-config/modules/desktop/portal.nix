{ config, pkgs, ... }:

{
  # Universal XDG Desktop Portal configuration
  # Supports multiple desktop environments: Hyprland, Sway, GNOME, KDE, etc.
  xdg.portal = {
    enable = true;
    
    # Include portals for all desktop environments you might use
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk      # Universal GTK support
      xdg-desktop-portal-gnome    # For GNOME (if you add it back)
      # xdg-desktop-portal-kde    # Uncomment for KDE/Plasma
      # Note: Hyprland and Sway portals are handled by their respective program modules
    ];
    
    # Portal configuration per desktop environment
    config = {
      # Common fallback - automatic selection
      common = {
        default = "*";
      };
      
      # Hyprland configuration
      hyprland = {
        default = [ "hyprland" "gtk" ];
      };
      
      # Sway configuration (for when you add it)
      sway = {
        default = [ "wlr" "gtk" ];
      };
      
      # GNOME configuration (if you re-enable it)
      gnome = {
        default = [ "gnome" "gtk" ];
      };
      
    };
  };
}
