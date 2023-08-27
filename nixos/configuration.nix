# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # inputs.home-manager.nixosModules.home-manager
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  services.xserver = {
    layout = "us";
    enable = true;
    autorun = true;
    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "ken";
    };
    desktopManager = {
      xterm.enable = false;
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
	i3lock-color
	i3blocks
      ];

    };
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ken = {
    isNormalUser = true;
    description = "Ken Snyder";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    chatgpt-cli
    vscode-with-extensions
    mpv
    mpvScripts.youtube-quality
    vimPlugins.monokai-pro-nvim
    obsidian
    telegram-desktop
    discord
    whatsapp-for-linux
    _1password-gui
    _1password
    qutebrowser
    theme-obsidian2
    iconpack-obsidian
    ];
  };


  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # we need to do this if we want vscode (which is still a crutch for me)
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    i3
    i3lock-color
    wget
    polybarFull
    zls
    zfstools # Linux tools for working with ZFS pools
    haskellPackages.greenclip # Clip Manager which works with Rofi
    curl
    wget
    openssh
    gnupg
    gpgme
    gpg-tui
    mdp # Markdown Viewer
    xfce.thunar
    lf # text based file manager
    bat
    exa
    htop
    du-dust
    git
    lxappearance
    dracula-theme
    juno-theme
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    vimix-icon-theme
    gh
    chromium
    rofi
    lazygit
    findutils
    fzy
    trippy
    ripgrep
    arandr
    nitrogen
    alacritty
    delta
    autotiling # auto switch from horizontal to vertical in smart fashion
    neocomp # compositor for X11
    inetutils
    iperf3
    firefox
    unzip
    # nix-colors # https://github.com/Misterio77/nix-colors
    neovim
    neofetch
    helix
    papirus-icon-theme
    home-assistant-cli
    rustup
    rust-analyzer
    kubectl
    kubernetes-helm
    helm-ls
    home-manager # NixOS Home Manager
    marksman
    nodePackages.typescript-language-server
    nodejs_18
    go
    gopls
    gcc
    just
    starship
  ];


  environment.etc = {
    "xdg/gtk-2.0/gtkrc".text = ''
      gtk-error-bell=0
    '';
    "xdg/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-error-bell=false
      gtk-application-prefer-dark-theme=true
    '';
    "xdg/gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-error-bell=false
      gtk-appliction-prefer-dark-theme=true
    '';

  };


  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
