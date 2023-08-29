#!/usr/bin/env bash

# activates a user's home-manager profile
function activate_user() {
  echo "Updating User Configuration"
  echo "---------------------------"
  echo ""

  pushd ~/dotty/homey/
  nix build .#homeManagerConfiigurations.ken.activationPackage
  ./result/activate 
  popd
}
