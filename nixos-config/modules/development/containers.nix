{ config, pkgs, ... }:
{
  # Modern container runtime with GPU support
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };

  # Container registries
  virtualisation.containers.registries.search = [ "docker.io" ];

  # Container tools
  environment.systemPackages = with pkgs; [
    docker-compose
    buildah
    skopeo
    dive
  ];

  # Container networking
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  networking.firewall.trustedInterfaces = [ "podman0" ];

  # User access
  users.extraGroups.podman.members = [ "wilson" "keith" ];

  # Convenient aliases
  environment.shellAliases = {
    dc = "docker-compose";
    dcu = "docker-compose up";
    dcd = "docker-compose down";
    podman-nvidia = "podman run --device nvidia.com/gpu=all";
    podman-amd = "podman run --device=/dev/dri";
  };
}
