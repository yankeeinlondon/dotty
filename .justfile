RESET :='\033[0m'
BOLD := '\033[1m'
GREEN := '\033[38;5;2m'

default:
  @echo "{{BOLD}}DOTTY CLI{{RESET}}"
  @echo "--------------------------"
  @echo 
  @just --list
  @echo

manager *WM:


cmd := if "${WM}" == "i3" {
  "i3"
} else if "${WM}" == "sway" {
  "sway"
} else if "${WM}" == "hyprland" {
  "hyprland"
} else { "" }

msg := if "${WM}" == "" {
  "syntax: just manager <mngr>\n\n- where <mngr> is one of the following: i3 | sway | hyprland\n"
} else {
  "Booting to ${WM} windows manager\n----------------------------------\n\n"
}

# testing conditionals
testing *WM:
  @bash -c "if "{{WM}}" == ""; then echo "oopsie"; fi"

  @echo

