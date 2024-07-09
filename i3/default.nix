{ config, pkgs, ... }: 

{
  imports = [
    ../nixos/configuration.nix
    ../wm/x11.nix
  ];

  networking.hostName = "i3";

  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.windowManager.i3.enable = true;
  
  # Packages
  environment.systemPackages = with pkgs; [
    i3
    i3lock-color

    polybarFull
  ];

}
