{ services, environment, config, pkgs, ... }:

{
  services.xserver = {
    layout = "us";
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    rofi
    neocomp # compositor for X11
  ];

}
