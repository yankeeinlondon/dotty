{ config, lib, pkgs, ... }:

{
  imports = [
    ../nixos/configuration.nix
    ../wm/wayland.nix
  ];

  networking.hostName = "hyprland";

  programs.hyprland = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    swww
    hyprland
    xdg-desktop-portal-hyprland
    hyprland-protocols
    hyprpaper
    cliphist
  ];
}

