{ pkgs ? import <nixpkgs> {}
, lib
, ...
}:
let
  src = (pkgs.lib.cleanSource ../stage1).outPath;
in
rec {
installer-files = (lib.cleanSourceWith {name = "installer-files"; src= ../installer;}).outPath ;

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
    chmod 766 /installer/create-filesystems
    /installer/create-filesystems
    mount /dev/sda1 /mnt
    swapon /dev/sda2
    cp -avr /installer /mnt/installer
    mkdir -p /mnt/etc/nixos
    cd /mnt/etc/nixos
    ln -s ../../installer/configuration.nix .

    nixos-generate-config --root /mnt --show-hardware-config > /mnt/etc/nixos/hardware-configuration.nix

    cd /mnt/installer
    ln -s ../etc/nixos/hardware-configuration.nix .
    cd
    # check syntax and fallback !
    # cp .. /mnt/etc/nixos/configuration.nix
    nixos-install --no-root-passwd
    reboot
'';
}
