set dotenv-load

repo := `pwd`

RESET :='\033[0m'
BOLD := '\033[1m'
GREEN := '\033[38;5;2m'

default:
  @echo
  @echo "DOTTY CLI"
  @echo "------------------"
  @just --list
  @echo


# system and nixos info 
info:
  @echo "Nix Info:"
  @echo
  @nix flake metadata 
  @nix-info
  @nix flake show
  @echo 
  @echo "System Info:"
  neofetch

# rebuild the current profile and switch to it
rebuild:
  @echo "Build Dotty Flake and Switch"
  @echo "----------------------------"

  sudo nixos-rebuild switch --flake ./

# build the current profile but do not add to the bootloader or activate it yet
test-build:
  @echo "Test Build of Dotty Flake"
  @echo "-------------------------"

  sudo nixos-rebuild test --flake ./

# build and prep the bootload for the "sway" manager
sway:
  @echo "Switching to the Sway tiling manager"
  @echo "------------------------------------"

  sudo nixos-rebuild boot --flake ./#sway

# build and prep the bootloader for the "hyprland" manager
hyprland:
  @echo "Switching to the Hyprland tiling manager"
  @echo "------------------------------------"

  sudo nixos-rebuild boot --flake ./#hyprland

# switch to GNOME desktop
dotty:
  @echo "Switching to the Gnome desktop"
  @echo "------------------------------"
  sudo nixos-rebuild boot --flake ./#dotty

# build and prep the i3 manager under x11
i3:
  @echo "Switching to the i3 tiling manager"
  @echo "----------------------------------"

  sudo nixos-rebuild boot --flake ./#i3

# garbage collect unused packages
trash *PARAMS:
  @echo "Garbage collecting unused packages to clear disk space"
  @echo "------------------------------------------------------"

  sudo nix-collect-garbage {{PARAMS}}

# updates the current flake profile while updating all dependencies
update:
  @echo "Upgrading all packages in the current profile (and switching to it)"
  @echo "-------------------------------------------------------------------"

  sudo nixos-rebuild switch --flake ./ --upgrade-all

logs:
  @echo "System Logs"
  @echo "-----------"
  journalctl -b
