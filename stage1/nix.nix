{ pkgs ? import <nixpkgs> {}
, ...
}:
let
  src = (pkgs.lib.cleanSource ../stage1).outPath;
  
in
rec {
setup-utils = pkgs.runCommand "setup-utils" {} ''
    mkdir -p "$out/lib/setup-utils"
    cd ${src}
    cp nix.nix target-config.nix $out/lib/setup-utils/
'';

greeting = pkgs.writeScriptBin "greeting" ''
    #!${pkgs.stdenv.shell}
    echo "Hello NIXINSTALL"
'';
  
hetzner-config = pkgs.runCommand "hetzner-config" {} ''
    #!${pkgs.stdenv.shell}
    mkdir -p "$out"
    cd $out
    ${pkgs.curl}/bin/curl http://169.254.169.254/hetzner/v1/metadata
'';

auto-install = pkgs.writeScriptBin "auto-install" ''
    #!${pkgs.stdenv.shell}
    set -e
    parted /dev/sda -- mklabel msdos
    parted /dev/sda -- mkpart primary 1MiB ~512MB
    parted /dev/sda -- mkpart primary linux-swap -512MB 100%
    mkfs.ext4 -L nixos /dev/sda1
    mkswap -L swap /dev/sda2
    mount /dev/disk/by-label/nixos /mnt
    swapon /dev/sda2
    cp ${setup-utils}/lib/setup-utils/target-config.nix /mnt/etc/configuration.nix
    nixos-install --no-root-passwd
'';

greeter-service = {
    wantedBy = [ "multi-user.target" ]; 
    after = [ "network.target" ];
    description = "auto install NIXOS on HD";
    serviceConfig = {
        ExecStart = ''${greeting}/bin/greeting'';
    };
};

}
