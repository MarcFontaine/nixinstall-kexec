{ config, pkgs, lib, ... }:
let
  json = builtins.fromJSON (builtins.readFile ./hetzner-metadata.json);
in
with lib;
{
  networking.hostName = if json == null    
    then mkDefault "nixos"
    else mkDefault json.hostname;
  users.users.root.openssh.authorizedKeys.keys = if json == null
    then mkDefault []
    else mkDefault json.public-keys;                                              
}
