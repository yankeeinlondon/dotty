{ config, pkgs, ... }: 

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    # load all configuration required for the i3 windows manager
    ./all.nix
    ./x11.nix
  ];

  # the remainder of this configuration is specifically for
  # configuration only intended for the [i3wm]()
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
