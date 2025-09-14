{ config, pkgs, ... }:

{
  # Nix package manager configuration
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = [
        "nix-command" 
        "flakes"
        "ca-derivations"        # Content-addressed derivations
      ];
      auto-optimise-store = true;
      trusted-users = ["root" "@wheel"];
      # Enable parallel building
      max-jobs = "auto";
      # Use all available cores
      cores = 0;
    };

    # Automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Environment variables
  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DATA_HOME = "$HOME/.local/share";
    EDITOR = "neovim";
  };
}
