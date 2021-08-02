# Open in tmux if in a visual shell
if [ "$TERM" == "xterm-256color" ] || [ "$TERM" == "alacritty" ]; then
  hash tmux && [ "$INPUTRC" != "~/.fig/nop" ] && [ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit; }
fi

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"
