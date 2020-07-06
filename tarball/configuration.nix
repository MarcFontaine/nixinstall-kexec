# configuration of the tarball
{ lib, pkgs, config, ... }:
with lib;
{
  imports = [
    <nixpkgs/nixos/modules/installer/netboot/netboot-minimal.nix>
    ./kexec.nix
    ./auto-installer.nix
  ];
  boot.supportedFilesystems = [ ];
  boot.loader.grub.enable = false;
  boot.kernelParams = [
    "panic=90" "boot.panic_on_fail" # reboot the machine upon fatal boot issues
  ];
  #todo: set runlevel ! NO console login !
  systemd.services.sshd.wantedBy = mkForce [ "multi-user.target" ];
  networking.hostName = "nix-installer";
  users.users.root.hashedPassword = "XXXnologinXXX";
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYkGyB2elWkWEb6s363j+BWMqvXbalZF0s4kuK9chYpgPkihtVV7zp2gMPGpYkUbmkLAxiSQHg1W4Q13fzmyoF+aPqJ6YhmaszQqdbgbPLp3tZyLE+TxVVUlS0pTL7RINDfKE7hCAGseNxBGcmMqKRh1oVvEuu/cnf+bAnoST2kNlVn/8o6R1njuSOeTrTnqemYq+NMuge2m6bfnpIVZkZTW1fkpIDYSCutdlQ9shEHOu9QokoBEumyvNTn5qPJhmKBFs3+O4ohWiBbNKxX9LB2diU2GtKAIrsyV6pxNgoqmMfNU3Xt7whi2JsA14m0G5h0Q0Wew862ka5GCdxIWSSXlSsKw2Z4LjdwxCwK/2LgSLq+BMcZKv4EMc/zoJW/y/xfg4/8biT9mAOaalDPaL75nPJbK43ouxuM1Mjacjy95DdWEohewgKrRkmlBimO9Uscaz/BbaM0HwZ34r27h+VgRpZJ69n8FHqI/UCoTXqDFWMsafn1S8txIfhc9nrefkC+HLuZ0O8/5OQXyAby7FanEx2ydsidt36sQMRVlMyY2vMwsG37RoqlAvRlIrIVbyXuW1Kw7+BwzBL9yIoXuccyA4zrDiSMZNU0TSo4HGC0xp46jquqwk4Md3YW4F+nMrfO2M6psCf+9k6O3Sj0K5pyZYzMBxyw76jTuAUV7u72w== cardno:000611300226"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDpWmYeIC1mFSadTeNN23GJO8UbMOBgMAZQ1O5W1+Vx42NmQ8Oeszr5Nn70t6PW4fCpOTooa6x9SmFnQJsviXxfJfWLoAlXg1+gtaGuCelj/MHXkfa12d3vCxydfBgg+uvg1mMAH7thyezFJk7turMjPxz8vsVZVX+IiFkFbVs8SvCKLl0CxRD+SDUsa9Sz+j29OhIke19/5NTk6FpL5lCPv0FkvKejeczXCETxqLPZ9MEgxrMfOVLfsE9r/Pz9TGQgnPvDrP6jmtwlISVe/F7hviBPDZ0IkoU3U69LaGM48gSilFOdoYiJCZniZxcUrMFq00ZTuIAMGDXx+VzRXzGg0TT1NjDR6hV2nmV4B6E/iaG56ySBaxxEJEJb8VOWm6yHzuhiewqrkncZDIwsqSsyknKttotS67xrHP7wX05w5uUfi2cPCARGGXspp0whf0ZNc0KTiR3bYnNWaPrKUD920OZVesypSdh5c5Q3D/gMRRAULdeh6kibg7a57C7q3ZutdC19Y6pwy+W/zJdrwAdHYiiNBvSWr8MQzHqiVmaB8Q8UxEGM5qImAucAHpZyUaHlyHuc/XcOllj0m8dDYmSoL3gD9kKHlT09BSMaU28JIdvY4hTYnV8x2HCc92pwFw/XpqjU3JkVeFnyGztbEaXW8h3mxeD3bExeLZsgaX8AZQ== cardno:000611300214"
    ];

  environment.systemPackages = with pkgs; [
  ];
}
