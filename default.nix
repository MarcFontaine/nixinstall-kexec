{
}:
let
  nixsrc = builtins.fetchTarball {
    name = "nixpkgs-src";
    url  = "https://github.com/NixOS/nixpkgs/archive/20.03.tar.gz";
    sha256 = "0182ys095dfx02vl2a20j1hz92dx3mfgz2a6fhn31bqlp1wa8hlq";
  };

  configuration = ./tarball/configuration.nix;
  nixos = import "${nixsrc}/nixos" {inherit configuration;};
in
nixos.config.system.build.kexec_tarball
