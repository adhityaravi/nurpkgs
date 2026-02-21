# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage
{pkgs ? import <nixpkgs> {}}: {
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib {inherit pkgs;}; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  # Neovim plugins
  skifree-nvim = pkgs.callPackage ./pkgs/nvim/skifree {};

  # Tools
  sqlit = pkgs.callPackage ./pkgs/tools/sqlit {};
  uptimekit = pkgs.callPackage ./pkgs/tools/uptimekit {};
  youtube-music-cli = pkgs.callPackage ./pkgs/tools/youtube-music-cli {};
}
