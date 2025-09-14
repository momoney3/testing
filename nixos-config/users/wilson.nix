{ config, pkgs, zen-browser, ... }:

{
  users.users.wilson = {
    isNormalUser = true;
    description = "Wilson";
    extraGroups = [ "networkmanager" "wheel" "video" "podman" ];
    shell = pkgs.fish;
    
    packages = with pkgs; [
      # Desktop applications
      obsidian
      spotify
      remmina
      ghostty
      neomutt
      
      # Browser
      zen-browser.packages.${pkgs.system}.default
    ];
  };
}
