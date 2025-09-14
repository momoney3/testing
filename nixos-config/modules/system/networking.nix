{ config, pkgs, ... }:

{
  networking = {
    hostName = "foxGo";
    networkmanager.enable = true;
    enableIPv6 = false;
    
    # Secure firewall configuration
    firewall = {
      enable = true;
      # Allow specific ports if needed
      allowedTCPPorts = [ 
        # 22    # SSH (uncomment if needed)
        # 80    # HTTP (uncomment if needed)
        # 443   # HTTPS (uncomment if needed)
      ];
      allowedUDPPorts = [ ];
      
      # Trust loopback interface
      trustedInterfaces = [ "lo" ];
      
      # Allow ping responses
      allowPing = true;
      
      # Enable logging for debugging
      logReversePathDrops = true;
    };
  };

  # Network tools
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    wget
    curl
  ];
}
