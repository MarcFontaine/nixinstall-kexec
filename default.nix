{
}:
let
  configuration = ./stage0/configuration.nix;
  nixos = import <nixpkgs/nixos> {inherit configuration;};
in
nixos.config.system.build.kexec_tarball
