{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Core utilities
    git
    pv

    # File and text manipulation
    wget
    curl
    bat
    ripgrep
    ripgrep-all
    unzip
    fd
    fzf
    jq
    yq      # YAML processor
    bc
    dust
    duf
    procs
    btop
    trash-cli

    # Documentation and database
    tldr
    litecli

    # Security tools
    pass
    gnupg
    pinentry-curses
    vault-bin 

    # Navigation and productivity
    zoxide
    eza
    yazi
    superfile
    sshfs  # SSH utilities

    # Shell enhancements
    starship
    nushell

    # Terminal utilities
    chafa
    ueberzugpp
    viu

    # Development databases
    sqlite
    sqlite.dev
    sqlite-web
    sqlite-utils
    postgresql

    # Clipboard (Wayland)
    wl-clipboard
    cliphist
    # clipman

  # Fish plugins
    fish
    grc
    nix-index
    fishPlugins.hydro
    fishPlugins.forgit
    fishPlugins.grc
    fishPlugins.fzf-fish
  ];

  # Shell configuration
  programs.fish.enable = true;
  programs.zsh.enable = true;
  programs.starship.enable = true;

  # GPG agent configuration
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
