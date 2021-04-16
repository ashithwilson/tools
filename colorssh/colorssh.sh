#!/bin/bash

# Change iTerm2 color while on an SSH session
# iTerm2 tab color commands
# https://iterm2.com/documentation-escape-codes.html

if [[ -n "$ITERM_SESSION_ID" ]]; then
  tab_color() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
  }

  tab_reset() {
    echo -ne "\033]6;1;bg;*;default\a"
  }

  colorssh() {
    trap tab_reset INT EXIT
    tab_color "180" "220" "120"
    ssh "$@"
  }

  alias ssh='colorssh'
fi
