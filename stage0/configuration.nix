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
  systemd.services.sshd.wantedBy = mkForce [ "multi-user.target" ];
  # systemd.services.enable = true;
  networking.hostName = "nixinstall-kexec";
  users.users.root.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDVGGe2Y2+zrzCa3BiFVaCH9RzoMmsBHR+/xCL2eBanYkukLz8V6a9FsjYhtirlwXMojcxWQSHif5YKw1doAc6lMYUxkEU6IgNIN/hAzPOR9C6c0EktFDjiMMJ0C0QlFxumcPHiAMIltosF0Lkcr0jG+0KLt1UqLP48Ib1Zp3QLSYf9DziAoG0OUTx8yjq3kBvfpFboQPIdqhoc5bvKwIRhZoKDDKmdZajtN0Fq0CWeBV9HYyW7dWrqQh/uUTbP4PX3bAlid87xkJpJlwafZVdKb48Ktcic6AcByy5v/6bOMTTcpxWowQyUhRhdUdlCLHhx1e9ojwkoHz6jX3AsB/4uPu2skb9u3vGa4HvRrKOvZgVAFzVlHOJHxRjG9qHXom7vOuEqDKpX+tpfpQ+nu+QLSU+Js+bipCjBipVNVdM0WDgP1wVvMlPUX4zGKIszLDZH9iMDek3Clu3G6odygVlViJWOJ1q+VItFGUqYR2KpA5OuC4Px/dle9bEHo80JunvuGc8XXvgGAWGCC8jQqUsXwzXjmWHifxevB1p2c2zFSyWgvhUc+0ftWaYwZa+uAMg21Fb+VpFQSL7/Vl8t1ZPmipKgz0o0SQ9JjS1s9pvb2jlPb8N7qeX2O6rQxsqdmkhOKtqbB1QvFjzsj8QhUMfLdw4XmSl/moLyi5bq+Oo7Rw== cardno:000611300226"];

  environment.systemPackages = with pkgs; [
  ];
}
