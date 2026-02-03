# List available recipes
default:
    @just --list

# Update all packages across all categories
update-all:
    #!/usr/bin/env bash
    set -euo pipefail
    for dir in pkgs/*/; do
        category=$(basename "$dir")
        just update-category "$category"
    done

# Update all packages in a given category
update-category category:
    #!/usr/bin/env bash
    set -euo pipefail
    attrs=$(grep "callPackage ./pkgs/{{ category }}/" default.nix | sed 's/^\s*\([^ =]*\)\s*=.*/\1/')
    if [ -z "$attrs" ]; then
        echo "No packages found for category: {{ category }}"
        exit 0
    fi
    echo "$attrs" | while read -r attr; do
        echo ">>> Updating $attr"
        nix run nixpkgs#nix-update -- --flake "$attr" || echo "!!! Failed to update $attr, skipping"
    done

# Update a single package by attribute name
update pkg:
    nix run nixpkgs#nix-update -- --flake {{ pkg }}

# List all categories
list-categories:
    @ls -d pkgs/*/ 2>/dev/null | xargs -I{} basename {}

# List all packages in a category
list-packages category:
    @grep "callPackage ./pkgs/{{ category }}/" default.nix | sed 's/^\s*\([^ =]*\)\s*=.*/\1/'

# Build a single package
build pkg:
    nix build .#{{ pkg }}

# Build all packages
build-all:
    #!/usr/bin/env bash
    set -euo pipefail
    nix flake show --json 2>/dev/null | nix run nixpkgs#jq -- -r '.packages."x86_64-linux" // {} | keys[]' | while read -r pkg; do
        echo ">>> Building $pkg"
        nix build ".#$pkg" || echo "!!! Failed to build $pkg"
    done
