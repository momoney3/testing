{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ vault-bin ];
  environment.variables.VAULT_ADDR = "http://127.0.0.1:8200";
}
