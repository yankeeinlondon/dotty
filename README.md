# Dotty

A repo containing **flakes** and **dotfiles** for booting [**NixOS**]() with one of the following configurations:

## Configuration Options

### Using X11 Compositors

1. Boot with [i3wm]() Windows Manager

### Using Wayland Compositors

2. Boot to [sway]() compositor
3. Boot with [Hyprland]() compositor

## Key Commands

- **rebuild** - `sudo nixos-rebuild switch --flake ~/dotty/[ x11 | sway | hyprland]`


## Core System Packages

> available in all configuration options

- `curl` and `wget` - _for pulling down content via API's, etc._ 
- `neovim` and `helix` - _for editing_
- `alacritty` - _for terminal emulation_
- `htop` - _for performance monitoring_
- `bat` - _replacement for *nix **cat** command but with contextual coloring and paging_
- `exa` - _replacement for *nix **ls** command_ 
- `delta` - _for high quality diff paging_
- `du-dust` - _replacement for *nix **du** command_
- `just` - _nice command runner used often in Rust, C, and JS/TS_
- `git`, `gh`, and `lazygit` - _for versioning support_ 
- `starship` - _for prompt loveliness_
- `iperf3`, `inetutils`, `trippy` and `lsof` - _for network tooling_
- `nodejs_18`, `rustup`, `go` - _for baseline programming support_
- `marksman`, `nodePackages.typescript-language-server`, `helm-ls`, `gopls`, and `rust-analyzer` - _for better LSP support out of the box_
