{
  description = "NixOS configuration for AMD laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hardware.url = "github:NixOS/nixos-hardware";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, zen-browser, hardware, ... }@inputs: {
    nixosConfigurations.foxGo = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        # Host-specific configuration
        ./hosts/foxGo

        # Hardware profiles
        hardware.nixosModules.common-cpu-amd
        hardware.nixosModules.common-gpu-amd
        hardware.nixosModules.common-pc-laptop
        hardware.nixosModules.common-pc-laptop-ssd
      ];

      specialArgs = { inherit zen-browser; };
    };
  };
}
