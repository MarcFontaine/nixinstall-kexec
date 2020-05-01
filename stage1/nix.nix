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
    cp hetzner-config.nix $out/lib/setup-utils/
'';

auto-install-service = {
    wantedBy = [ "multi-user.target" ]; 
    after = [ "network.target" ];
    description = "Auto install NIXOS on HD";
    serviceConfig = {
      StandardOutput = "journal+console";
      StandardError  = "journal+console";
      ExecStart = ''${auto-install}/bin/auto-install'';
    };
};

auto-install = pkgs.writeScriptBin "auto-install" ''
    #!${pkgs.stdenv.shell}
    set -e
    parted -s /dev/sda \
       mklabel msdos \
       mkpart primary 1MiB 100%
    #       mkpart primary linux-swap ~512MB 100%
    mkfs.ext4 -L nixos /dev/sda1
    #    mkswap -L swap /dev/sda2
    mount /dev/sda1 /mnt
    #    swapon /dev/sda2
    nixos-generate-config --root /mnt
    cp ${setup-utils}/lib/setup-utils/target-config.nix /mnt/etc/nixos/configuration.nix
    nixos-install --no-root-passwd
    reboot
'';

#geht nicht wegen sandbox!
hetzner-config = pkgs.runCommand "hetzner-config" {} ''
    #!${pkgs.stdenv.shell}
    mkdir -p "$out"
    cd $out
    ${pkgs.curl}/bin/curl http://169.254.169.254/hetzner/v1/metadata
'';

}
