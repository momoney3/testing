{ config, pkgs, ... }:

{
  users.users.keith = {
    isNormalUser = true;
    description = "Keith";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    shell = pkgs.fish;
    
    packages = with pkgs; [
      # Add packages specific to Keith here
      # spotify  # Uncomment if needed
    ];
  };
}
