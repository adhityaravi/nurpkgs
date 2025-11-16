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

  # CLI plugins
  goose-cli = pkgs.callPackage ./pkgs/cli/goose {
    writableTmpDirAsHomeHook = pkgs.writableTmpDirAsHomeHook or null;
  };

  # Obsidian plugins
  obsidian-tasks = pkgs.callPackage ./pkgs/obsidian/tasks {};
  obsidian-everforest-enchanted =
    pkgs.callPackage ./pkgs/obsidian/everforest-enchanted {};
  obsidian-minimal = pkgs.callPackage ./pkgs/obsidian/minimal {};
  obsidian-minimal-settings =
    pkgs.callPackage ./pkgs/obsidian/minimal-settings {};
  obsidian-dataview = pkgs.callPackage ./pkgs/obsidian/dataview {};
  obsidian-git = pkgs.callPackage ./pkgs/obsidian/git {};
  obsidian-drawio = pkgs.callPackage ./pkgs/obsidian/drawio {};

  # Neovim plugins
  goose-nvim = pkgs.callPackage ./pkgs/nvim/goose {};
}
