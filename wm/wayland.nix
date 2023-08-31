{ services, environment, config, pkgs, ... }:

{
  imports = [
   ./base.nix
  ];

  xdg.portal.wlr.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # hint to electron apps to use wayland

    # If you're cursor becomes invisible; enable below
    # WLR_NO_HARDWARE_CURSORS = "1";
  };

  programs.xwayland.enable = true;
  hardware.opengl.enable = true;
  # hardware.opengl.mesaPackage = pkgs.mesa;
  security.polkit.enable = true;
  # Autologin
  services.xserver.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "ken";
    gdm.enable = true;
    gdm.wayland = true;
  };

  environment.systemPackages = with pkgs; [
    wayland
    xwayland
    eww-wayland
    qt5-wayland qt6-wayland
    xdg-utils
    libsForQt5.polkit-kde-agent
    (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
    kitty
    wl-clipboard
    rofi-wayland 
    wayland-utils
    gnome3.adwaita-icon-theme
    glpaper 
    dunst 
    libnotify
    shotman # screenshot util for wayland 
  ];

}

