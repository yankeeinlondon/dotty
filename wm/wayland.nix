{ services, environment, config, pkgs, ... }:

{
  imports = [
    ./base.nix
  ];


  environment.systemPackages = with pkgs; [
  
  ];

}

