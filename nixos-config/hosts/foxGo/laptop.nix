{ config, pkgs, ... }:
{
  # TLP power management for hybrid GPU laptop
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      # CPU scaling
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      
      # AMD GPU power management
      RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
      RADEON_DPM_PERF_LEVEL_ON_BAT = "low";
      RADEON_DPM_STATE_ON_AC = "performance";
      RADEON_DPM_STATE_ON_BAT = "battery";
      
      # NVIDIA GPU power management (offload mode)
      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";
      
      # Docking station optimizations
      USB_AUTOSUSPEND = 1;
      PCIE_ASPM_ON_AC = "performance";      # Better for docks
      PCIE_ASPM_ON_BAT = "powersupersave";
      
      # Audio and network power saving
      SOUND_POWER_SAVE_ON_BAT = 10;
      WIFI_PWR_ON_BAT = "on";
      WOL_DISABLE = "Y";
    };
  };

  # Essential laptop services
  services = {
    fstrim.enable = true;
    fwupd.enable = true;
    upower.enable = true;
    thermald.enable = true;
    
  # Bluetooth GUI management
    blueman.enable = true;

    # Trackpad configuration
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        middleEmulation = true;
        disableWhileTyping = true;
      };
    };
    
    # Power button and lid behavior (docking-aware)
    logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "ignore";  # Don't suspend when docked
      HandlePowerKey = "suspend";
      IdleActionSec = 1800;
    };
  };

  # Laptop utilities
  environment.systemPackages = with pkgs; [
    brightnessctl
    acpi
    powertop
  ];

  # Bluetooth with power management
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };
}


