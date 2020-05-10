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
    wantedBy = [ "multi-user.target"];
    before = [ "getty-pre.target" "getty.target"];

    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];

    description = "Auto install NIXOS on HD";
    serviceConfig = {
      StandardOutput = "tty";
      StandardError  = "tty";
      # run in an environment similar to a regular login
      ExecStart = ''/run/wrappers/bin/su -l root -c ${auto-install}/bin/auto-install 2>&1'';
    };
};

auto-install = pkgs.writeScriptBin "auto-install" ''
    #!${pkgs.bash}/bin/bash
    ## #!/run/current-system/sw/bin/bash
    export PATH=$PATH:/run/current-system/sw/bin
    set -e
    source /installer/create-filesystems.sh

    cp -avr /installer /mnt/installer
    mkdir /mnt/etc
    ln -s -r  /mnt/installer /mnt/etc/nixos
    nixos-generate-config --root /mnt --show-hardware-config > /mnt/installer/hardware-configuration.nix

    # check syntax and fallback !
    # cp .. /mnt/etc/nixos/configuration.nix
    if [ -e /installer/set-channels.sh ]; then
      source /installer/set-channels.sh
    fi

    nixos-install --no-root-passwd
    umount /mnt
    echo "finished installing NIXOS"
    shutdown -r now
'';
}
