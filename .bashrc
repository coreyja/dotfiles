# Open in tmux if in a visual shell
if [ "$TERM" == "xterm-256color" ] || [ "$TERM" == "alacritty" ] || [ "$TERM" == "xterm-kitty" ]; then
  hash tmux && [ "$INPUTRC" != "~/.fig/nop" ] && [ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit; }
fi


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
