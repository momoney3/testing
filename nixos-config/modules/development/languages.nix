{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Go
    go

    # Python
    python3
    python3Packages.pip
    python3Packages.virtualenv

    # JavaScript/Node.js
    nodejs
    nodePackages.npm
    nodePackages.pnpm

    # Rust
    cargo
    rustc
    rustfmt
    clippy

    # Build tools and compilers
    gcc
    clang
    gnumake
    cmake
    ninja
    automake
    autoconf
    libtool
    glibc
    pkg-config

    # Language servers and tools
    lua-language-server
    luarocks
    lua5_1
    tree-sitter
  ];

  # Git configuration
  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
