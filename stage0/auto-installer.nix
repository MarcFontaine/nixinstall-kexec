args@{ pkgs, config, ... }:
let
  stage1 = import ../stage1/nix.nix args;
in
{
  environment.systemPackages = with pkgs; [
    stage1.setup-utils
    stage1.greeting
    stage1.auto-install
  ];
  systemd.services.greeter = stage1.greeter-service;
}
