{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Neovim with dependencies
    neovim
    imagemagick
    ghostscript
    tectonic
    mermaid-cli

    # Other editors
    emacs
    code-cursor

    # Terminal multiplexer
    tmux

  # Development environment tools
    direnv
    stow
    git-lfs
    httpie     # HTTP client
  ];

  # Development environment tools
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
