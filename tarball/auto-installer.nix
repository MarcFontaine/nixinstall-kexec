args@{ pkgs, config, ... }:
let
  utils = import ../utils/nix.nix args;
in
{
  environment.systemPackages = with pkgs; [
    utils.auto-install
  ];
  systemd.services.auto-install = utils.auto-install-service;
  system.build.extra_files = [
    {source = utils.installer-files; target = "/installer";}
  ];
}
