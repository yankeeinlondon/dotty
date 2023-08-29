{ services, environment, config, pkgs, ... }:

{
  imports = [
    ./base.nix
  ];

  services.xserver = {
    layout = "us";
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    rofi
    neocomp # compositor for X11
  ];

}

