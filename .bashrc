export PATH="/opt/homebrew/bin:$PATH";

# # Open in tmux if in a visual shell
# if [ "$TERM" == "xterm-256color" ] || [ "$TERM" == "alacritty" ] || [ "$TERM" == "xterm-kitty" ]; then
#   hash tmux && [ "$INPUTRC" != "~/.fig/nop" ] && [ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit; }
# fi
