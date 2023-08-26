{
  description = "X11 based configuration with i3 window manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
  };

  outputs = { self, nixpkgs }: 
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
      x11 = nixpkgs.lib.nixosSystem {

        specialArgs = { inherit system; };

        modules = [ 
        ./nixos/configuration.nix 
        ];
      };
  };
  };

}
