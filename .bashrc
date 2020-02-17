# Open in tmux if in a visual shell
if [ "$TERM" == "xterm-256color" ] || [ "$TERM" == "alacritty" ]; then
  hash tmux && [ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit; }
fi
