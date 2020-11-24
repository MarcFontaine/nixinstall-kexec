{
}:
let
  nixsrc = builtins.fetchTarball {
    name = "nixpkgs-src";
    url  = "https://github.com/NixOS/nixpkgs/archive/20.09.tar.gz";
    sha256 = "1wg61h4gndm3vcprdcg7rc4s1v3jkm5xd7lw8r2f67w502y94gcy";
  };

  configuration = ./tarball/configuration.nix;
  nixos = import "${nixsrc}/nixos" {inherit configuration;};
in
nixos.config.system.build.kexec_tarball
