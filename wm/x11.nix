{ services, environment, config, pkgs, ... }:

{
  imports = [
    ./base.nix
  ];

  services.xserver = {
    layout = "us";
    enable = true;
    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "ken";
    };
    xkbVariant = "";
  };
  
  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  environment.systemPackages = with pkgs; [
    rofi
    chromium
    neocomp # compositor for X11
    haskellPackages.greenclip # Clip Manager which works with Rofi
    juno-theme
    lxappearance xfce.thunar 
    mdp # Markdown Viewer
    nitrogen
    nsxiv # https://nsxiv.codeberg.page
    clipboard-jh
  ];

}

