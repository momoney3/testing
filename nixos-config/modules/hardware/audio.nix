{ config, pkgs, ... }:

{
  # Enable real-time audio
  security.rtkit.enable = true;

  # PipeWire audio server
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Audio control packages
  environment.systemPackages = with pkgs; [
    playerctl
    pavucontrol  # PulseAudio volume control GUI
  ];
}
