{ config, pkgs, ... }:

{
  # Add experimental features for Flakes support
  nix.settings.experimental-features = [ "flakes" "nix-command" ];
  # Allow for non-free packages to be installed
  nixpkgs.config.allowUnfree = true;
  # Point to user's home-manager configuration


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


  # GTK settings
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
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      fira-code
      fira-code-symbols
      ( nerdfonts.override { fonts = [ "DroidSansMono" ]; })
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];

    #fontConfig = {
    #  defaultFonts = {
    #    serif = [];
    #    sanSerif = [];
    #    monoSpace = [i "firacode" "monopace" ];
    #  };
    #};
    
  };


 
  programs.starship.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [
    # wget and curl for network requests
    wget curl
    # SSH and GPG 
    openssh gnupg signing-party 
    # proramming language support 
    rustup nodejs_18 go 
    # language servers
    nil gopls rust-analyzer nodePackages.typescript-language-server marksman zls vimPlugins.null-ls-nvim helm-ls
    # browser support
    firefox qutebrowser 
    # network utilities
    iperf3 inetutils trippy
    # system utilities 
    fzy ripgrep htop findutils zip unzip unrar p7zip socat killall
    lf # text based file manager
    home-manager # NixOS Home Manager
    neofetch
     
    # quality of life
    exa lazygit du-dust bat delta just
    autotiling # auto switch from horizontal to vertical in a smart fashion
    mpv
    mpvScripts.youtube-quality

    # productivity
    obsidian theme-obsidian2 iconpack-obsidian
    # version control
    git git-crypt gh
    # terminal
    alacritty
    # UI nicities
    arandr 
    juno-theme

    # k8s
    kubectl
    kubernetes-helm

    # editors
    neovim helix vscode-with-extensions
    # neovim plugins
    vimPlugins.nvim-treesitter-parsers.jsonc vimPlugins.nvim-treesitter-parsers.javascript vimPlugins.nvim-treesitter-parsers.regex vimPlugins.nvim-treesitter-parsers.lua vimPlugins.nvim-treesitter-parsers.vue vimPlugins.nvim-treesitter-parsers.wgsl vimPlugins.nvim-treesitter-parsers.zig vimPlugins.nvim-treesitter-parsers.typescript vimPlugins.nvim-treesitter-parsers.toml vimPlugins.nvim-treesitter-parsers.svelte vimPlugins.nvim-treesitter-parsers.terraform vimPlugins.nvim-treesitter-parsers.sql vimPlugins.nvim-treesitter-parsers.rust vimPlugins.nvim-treesitter-parsers.python vimPlugins.nvim-treesitter-parsers.puppet vimPlugins.nvim-treesitter-parsers.php vimPlugins.nvim-treesitter-parsers.mermaid vimPlugins.nvim-treesitter-parsers.json vimPlugins.nvim-treesitter-parsers.graphql vimPlugins.nvim-treesitter-parsers.go vimPlugins.nvim-treesitter-parsers.cue vimPlugins.nvim-treesitter-parsers.css vimPlugins.nvim-treesitter-parsers.comment vimPlugins.nvim-treesitter-parsers.cmake vimPlugins.nvim-treesitter-parsers.bash vimPlugins.nvim-treesitter-parsers.awk vimPlugins.nvim-treesitter-parsers.astro vimPlugins.cmp-treesitter vimPlugins.nvim-treesitter-context
    vimPlugins.nvim-treesitter # https://github.com/nvim-treesitter/nvim-treesitter 
    vimPlugins.cmp-nvim-lsp # https://github.com/hrsh7th/cmp-nvim-lsp
    vimPlugins.telescope-zf-native-nvim # https://github.com/natecraddock/telescope-zf-native.nvim 

    # C lang support
    gcc
  ];
}
