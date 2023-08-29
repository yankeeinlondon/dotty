{ services, environment, config, pkgs, ... }:

{
  imports = [
   ./base.nix
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # hint to electron apps to use wayland

    # If you're cursor becomes invisible; enable below
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  programs.xwayland.enable = true;
  hardware.opengl.enable = true;
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
    kitty
    rofi-wayland 
    wl-clipboard
    waybar
    wayland-utils
    glpaper 
    dunst 
    libnotify
    shotman # screenshot util for wayland 
    keepassxc

  ];

}

