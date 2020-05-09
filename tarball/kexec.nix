{ pkgs, config, ... }:
let
  kexectools = pkgs.pkgsStatic.kexectools;
  bb = pkgs.pkgsStatic.busybox;
in
{
  system.build = rec {
    image = pkgs.runCommand "image" { buildInputs = [ pkgs.nukeReferences ]; } ''
      mkdir $out
      echo "init=${builtins.unsafeDiscardStringContext config.system.build.toplevel}/init ${toString config.boot.kernelParams}" > $out/cmdline
      cp ${config.system.build.kernel}/bzImage $out/kernel
      nuke-refs $out/kernel
      cp ${config.system.build.netbootRamdisk}/initrd $out/initrd
      # is it safe to nuke-refs on a squash-fs ? probably not !!
      # may even depend on the compressen algorithm that is used
      # error : compressed data--crc error
      nuke-refs $out/initrd
    '';
    kexec_script = pkgs.writeTextFile {
      executable = true;
      name = "kexec-nixos";
      text = ''
        #!${bb}/bin/sh
        export PATH=${bb}/bin:${kexectools}/bin
        set -x
        set -e
        cd $(mktemp -d)
        pwd
        mkdir initrd
        cd initrd
        if [ -d /installer ]; then
          cp -avr /installer .
        fi
        find . | cpio -o -H newc | gzip -9 > ../extra.gz
        cd ..
        cat ${image}/initrd extra.gz > final.gz

        kexec -l ${image}/kernel --initrd=final.gz --append="init=${builtins.unsafeDiscardStringContext config.system.build.toplevel}/init ${toString config.boot.kernelParams}"
        sync
        echo "executing kernel, filesystems will be improperly umounted"
        kexec -e
        '';
    };
  };
  boot.initrd.postMountCommands = ''
    cp -avr /installer /mnt-root/
  '';
  system.build.kexec_tarball = pkgs.callPackage <nixpkgs/nixos/lib/make-system-tarball.nix> {
    storeContents = [
      { object = config.system.build.kexec_script; symlink = "/kexec_nixos"; }
    ];
    contents = config.system.build.extra_files;
  };
}
