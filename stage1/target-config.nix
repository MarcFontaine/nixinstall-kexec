{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";


  networking.useDHCP = false;
  networking.interfaces.ens3.useDHCP = true;

  time.timeZone = "Europe/Amsterdam";

  environment.systemPackages = with pkgs; [
    emacs git wget
  ];

  services.openssh.enable = true;
  system.stateVersion = "20.09";
  systemd.services.sshd.wantedBy = lib.mkForce [ "multi-user.target" ];
  networking.hostName = "mfnixos";
  users.users.root.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDVGGe2Y2+zrzCa3BiFVaCH9RzoMmsBHR+/xCL2eBanYkukLz8V6a9FsjYhtirlwXMojcxWQSHif5YKw1doAc6lMYUxkEU6IgNIN/hAzPOR9C6c0EktFDjiMMJ0C0QlFxumcPHiAMIltosF0Lkcr0jG+0KLt1UqLP48Ib1Zp3QLSYf9DziAoG0OUTx8yjq3kBvfpFboQPIdqhoc5bvKwIRhZoKDDKmdZajtN0Fq0CWeBV9HYyW7dWrqQh/uUTbP4PX3bAlid87xkJpJlwafZVdKb48Ktcic6AcByy5v/6bOMTTcpxWowQyUhRhdUdlCLHhx1e9ojwkoHz6jX3AsB/4uPu2skb9u3vGa4HvRrKOvZgVAFzVlHOJHxRjG9qHXom7vOuEqDKpX+tpfpQ+nu+QLSU+Js+bipCjBipVNVdM0WDgP1wVvMlPUX4zGKIszLDZH9iMDek3Clu3G6odygVlViJWOJ1q+VItFGUqYR2KpA5OuC4Px/dle9bEHo80JunvuGc8XXvgGAWGCC8jQqUsXwzXjmWHifxevB1p2c2zFSyWgvhUc+0ftWaYwZa+uAMg21Fb+VpFQSL7/Vl8t1ZPmipKgz0o0SQ9JjS1s9pvb2jlPb8N7qeX2O6rQxsqdmkhOKtqbB1QvFjzsj8QhUMfLdw4XmSl/moLyi5bq+Oo7Rw== cardno:000611300226"];

}

