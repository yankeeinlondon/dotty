# borrowed from wiltaylor/dotfiles
with builtins;
rec {
  defaultSystems = [
    "aarch64-linux"
    "aarch64-darwin"
    "x86_64-linux"
    "x86_64-darwin"
  ];

  searchBlacklist = [
    "hyper-haskell-server-with-packages"
  ];

  evalMods = { allPkgs, systems ? defaultSystems, modules, args ?{} }: withSystems systems (sys: let
    pkgs = allPkgs."${sys}";
    in pkgs.lib.evalModules {
      inherit modules;
      specialArgs = { inherit pkgs; }; 
  });

  mkPkgs = { nixpkgs, systems ? defaultSystems, overlays ? [] }: withSystems systems (sys: let
  import nixpkgs {
    system = sys;
    config = cfg;
    overlays = overlays;
  });

  mkOverlays = { allPkgs, systems ? defaultSystems, overlayFunc }: withSystems systems (sys:
    let pkgs = allPkgs."${sys}";
    in overlayFunc sys pkgs);

  withDefaultSystems = withSystems defaultSystems;
  withSystems = systems: f: foldl' (cur: nxt:
  let
    ret = {
      "${nxt}" = f nxt;
    };
  in cur // ret) {} systems;

  mkNixOSConfig = { name, nixpkgs, allPkgs, system, modules ? [../modules], cfg ? {}, ...}: 
  let
    pkgs = allPkgs."${system}";
  in nixpkgs.lib.nixosSystem {
    inherit system;

    modules = [
      cfg 
      {
        imports = modules;
        
        nixpkgs.pkgs = pkgs;
        system.stateVersion = "23.05";
        networking.hostName = "${name}";
      }
    ];
  };

  mkSearchablePackages = allPkgs:
  let
    filterBadPkgs = pkgs;
    let
      badList = filter (a: 
      let
        res = tryEval(getAttr a pkgs);
        data = if res.success then pkgs."${a}" else {};
      in (res.success == false)) (attrNames pkgs) ++ searchBlacklist;
    in removeAttrs pkgs badList;
  in foldl' (l: r: let
    ret = { "${r}" = (filterBadPkgs allPkgs."${r}"); };
  in l // ret) {} (attrNames allPkgs);
}
