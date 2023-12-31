{ config, lib, pkgs, ... }:

{
  imports = [
    ../nixos/configuration.nix
    ../wm/wayland.nix
  ];

  networking.hostName = "sway";
  xdg.portal.wlr.enable = true;

  wayland.windowManager.sway {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      startup = [
        # { command = "firefox"; }
      ];
    };
    extraConfig = ''
      bindsym Print                 exec shotman -c output
      bindsym Print+Shift           exec shotman -c region
      bindsym Print+Shift+Control   exec shotman -c window
    '';
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };

  environment.systemPackages = with pkgs; [
    swaylock-effects
    waybar
    swayidle
    mako
    wdisplays
    swaybg
  ];
}

