{ config, pkgs, ... }:

{
  # Virtualization services
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
      };
    };
    spiceUSBRedirection.enable = true;
  };

  # Programs
  programs = {
    virt-manager.enable = true;
    dconf.enable = true;
  };

  # Services
  services.spice-vdagentd.enable = true;

  # User permissions
  users.groups.libvirtd.members = [ "keith" "wilson" ];

  # System packages
  environment.systemPackages = with pkgs; [
    # Core virtualization tools
    virt-manager
    virt-viewer
    
    # SPICE components
    spice
    spice-gtk
    spice-protocol
    
    # Windows guest support
    win-virtio
    win-spice
    
    # Additional tools
    libguestfs-with-appliance
    bridge-utils
    adwaita-icon-theme
  ];

  # Auto-start default network (fixed version)
  systemd.services.libvirtd-default-network = {
    description = "Auto-start libvirt default network";
    wantedBy = [ "multi-user.target" ];
    after = [ "libvirtd.service" ];
    requires = [ "libvirtd.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
      ExecStart = pkgs.writeShellScript "start-libvirt-network" ''
        # Set network to autostart
        ${pkgs.libvirt}/bin/virsh net-autostart default
        
        # Only start if not already active
        if ! ${pkgs.libvirt}/bin/virsh net-list --name | grep -q "^default$"; then
          ${pkgs.libvirt}/bin/virsh net-start default
        fi
      '';
    };
  };

  # Polkit rules for user access
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (action.id == "org.libvirt.unix.manage" &&
            subject.isInGroup("libvirtd")) {
                return polkit.Result.YES;
        }
    });
  '';

  # Kernel configuration
  boot = {
    kernelModules = [ "kvm-amd" "kvm-intel" "vfio-pci" ];
    extraModprobeConfig = ''
      options kvm_amd nested=1
      options kvm_intel nested=1
    '';
  };
}
