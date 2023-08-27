{
  description = "NixOS switchable configuration for i3, sway, and Hyprland tiling managers";

  inputs = {
    # Packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Colors
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:  
    let
      system = "x86_64-linux";
    
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

    in 
    {
      nixosConfigurations = {
        # i3 configuration using X11
        i3 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system; };

        # load cross configuration file (which in turn loads hardware config)
          modules = [ 
            ./nixos/configuration.nix 
          ];
        };

        #homeConfigurations = {
        #  "ken@nixos" = home-manager.lib.homeManagerConfiguration {
        #    extraSpecialArgs = { inherit inpts; };
        #    modules = [ ./homey/home.nix ];
        #  };
        #};
    };
  };

}
