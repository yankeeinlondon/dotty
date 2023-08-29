#!/usr/bin/env bash


function test_rebuild() {
  echo "Testing a rebuild of Dotty (not switching)"
  echo "------------------------------------------"
  echo ""

  sudo nixos-rebuild test --flake ./#i3

  echo ""
}


function rebuild_and_switch() {
  echo "Rebuilding Dotty (and switching to this build)"
  echo "----------------------------------------------"

  sudo nixos-rebuild switch --flake ./#i3

  echo ""
  echo "- rebuild completed!"
  echo ""
}


