{ config, pkgs, zen-browser, ... }:

{
  imports = [
    # Generated hardware configuration
    ./hardware-configuration.nix
    
    # System modules
    ../../modules/system/boot.nix
    ../../modules/system/networking.nix
    ../../modules/system/locale.nix
    ../../modules/system/nix-config.nix
    ../../modules/system/vault.nix

    # Hardware modules
    ../../modules/hardware/hybrid-graphics.nix
    ../../modules/hardware/graphics.nix
    ../../modules/hardware/audio.nix
    
    # Desktop environment
    ../../modules/desktop/wayland.nix
    ../../modules/desktop/gnome.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/desktop/portal.nix
    ../../modules/desktop/theming.nix

    # Virtualization environment
    ../../modules/virtualization/libvirt.nix

    # Development environment
    ../../modules/development/languages.nix
    ../../modules/development/containers.nix
    ../../modules/development/editors.nix
    ../../modules/development/cli-tools.nix
    
    # User configurations
    ../../users/wilson.nix
    ../../users/keith.nix
    
    # Host-specific settings
    ./laptop.nix
  ];

  # System version
  system.stateVersion = "25.05";

  # Pass zen-browser to users
  _module.args = { inherit zen-browser; };
}
