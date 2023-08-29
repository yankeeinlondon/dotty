{ config, lib, pkgs, ... }:

{
  imports = [
    ../nixos/configuration.nix
    ../wm/wayland.nix
  ];

  networking.hostName = "sway";

  programs.sway = {
    enable = true;
  };

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
    }
    extraConfig = ''
      bindsym Print                 exec shotman -c output
      bindsym Print+Shift           exec shotman -c region
      bindsym Print+Shift+Control   exec shotman -c window
    '';
  };

  environment.systemPackages = with pkgs; [
    swaylock-effects
    swaybg
  ];
}

