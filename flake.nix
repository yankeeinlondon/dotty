{
  description = "Dotty: a NixOS configuration for i3, sway, and Hyprland tiling managers";

  inputs = {
    # Packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # ensure home-manager uses same nixpkgs that we do
    # Colors
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:  
    let # pre-computed let block
      system = "x86_64-linux";
    
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;
      home = home-manager.lib;
    in 
    {
      nixosConfigurations = {
        # i3 configuration using X11
        i3 = lib.nixosSystem {
        specialArgs = { inherit inputs system; };
          modules = [
            ./i3/default.nix
          ];
        };
        
        # Sway manager running under Wayland
        sway = lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./sway/default.nix
          ];
        };

        # Hyprland manager running under Wayland 
        hyprland = lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./hyprland/default.nix
          ];
        };
      };

      homeManagerConfigurations = {
        ken = home.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./homey/home.nix
          ];
        };
      };
  };
 
}
