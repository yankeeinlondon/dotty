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

  # Autologin
  #wayland.displayManager = {
  #  autoLogin.enable = true;
  #  autoLogin.user = "ken";
  #  gdm.enable = true;
  #  gdm.wayland = true;
  #};

  environment.systemPackages = with pkgs; [
    wayland
    eww-wayland
    qt6.full 
    libsForQt5.systemsettings
    libsForQt5.polkit-kde-agent
    xdg-utils
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
    networkmanagerapplet
    shotman # screenshot util for wayland 
    swayimg # https://github.com/artemsen/swayimg
  ];

}

