{
}:
let
  configuration = ./configuration.nix;
  nixos = import <nixpkgs/nixos> {inherit configuration;};
in
nixos.config.system.build.kexec_tarball
