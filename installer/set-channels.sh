# This script is called to prepare the channels
nix-channel --add https://github.com/NixOS/nixpkgs/archive/20.09.tar.gz nixos
nix-channel --add https://github.com/NixOS/nixpkgs/archive/20.09.tar.gz nixpkgs
nix-channel --update
