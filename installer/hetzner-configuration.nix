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
  networking.hostName = "nixos";
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDVGGe2Y2+zrzCa3BiFVaCH9RzoMmsBHR+/xCL2eBanYkukLz8V6a9FsjYhtirlwXMojcxWQSHif5YKw1doAc6lMYUxkEU6IgNIN/hAzPOR9C6c0EktFDjiMMJ0C0QlFxumcPHiAMIltosF0Lkcr0jG+0KLt1UqLP48Ib1Zp3QLSYf9DziAoG0OUTx8yjq3kBvfpFboQPIdqhoc5bvKwIRhZoKDDKmdZajtN0Fq0CWeBV9HYyW7dWrqQh/uUTbP4PX3bAlid87xkJpJlwafZVdKb48Ktcic6AcByy5v/6bOMTTcpxWowQyUhRhdUdlCLHhx1e9ojwkoHz6jX3AsB/4uPu2skb9u3vGa4HvRrKOvZgVAFzVlHOJHxRjG9qHXom7vOuEqDKpX+tpfpQ+nu+QLSU+Js+bipCjBipVNVdM0WDgP1wVvMlPUX4zGKIszLDZH9iMDek3Clu3G6odygVlViJWOJ1q+VItFGUqYR2KpA5OuC4Px/dle9bEHo80JunvuGc8XXvgGAWGCC8jQqUsXwzXjmWHifxevB1p2c2zFSyWgvhUc+0ftWaYwZa+uAMg21Fb+VpFQSL7/Vl8t1ZPmipKgz0o0SQ9JjS1s9pvb2jlPb8N7qeX2O6rQxsqdmkhOKtqbB1QvFjzsj8QhUMfLdw4XmSl/moLyi5bq+Oo7Rw== cardno:000611300226"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDE0h7wl2jdIZUfeTdQ52X1WU7k4DZBKq+ikDFZsFLbGT6hB/N26JI4ly1PJcz5qGqhm4qAptfg8BhkwMMwp5Ia/59rb+9Lf9cujrQKbd8s8chhO6lIIADzw7Qi0ia0QF9n6Ys1FzgEF+UcTk65jzsFkw9vc6lkGmXHEmFKqD+1bLl3xoWeonyi+dVDGu+DxkM3Oq4gWqJoZsl0aBWhuxulftILpjWmhmrta7RbbkjMAPlVcRlTX7DzoIqV9HVX5M5e8WjJkkQATFLgZVQOx3HJjY9aIe5TRIcarfPEf0OfcSKimFrOP4rMOmCc1MYucQ+/5jgTvkF1BWnNSoZUu19IWuawWkkh7jJwUH1n1UmCMHuqcGA/JhaTjdwtjsRf5RUJNDZPAdnpppJYt733i7GhXq9N25aLVOE0qa1fjUvgM+mGB4EtehdFBwRelk7hyFwHBOK4GKtw7hw7zaSIOEDMRpIU0Bwx+Insu2Qwm8WcLQmChwuwpIvJPQ2xqY376YCWCv/tDdiPJMy3u9n2KB084/P2DFEXtI9xv2bUziQDOt68A42L9BC0MQtlQ3fDIVIOHXsrSdyyPVyZ2UU81NPgs+adNJZeVon0Bn0SlVzQhve0Lk0yBgTb3cV3hFy4YY7ArGP6FrmcZtaRt+/mn5HX/4oFc8Z1P57h/MiiPvp6XQ== cardno:000611300214"
  ];

}

