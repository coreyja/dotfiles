export PATH="/opt/homebrew/bin:$PATH";

# # Open in tmux if in a visual shell
# if [ "$TERM" == "xterm-256color" ] || [ "$TERM" == "alacritty" ] || [ "$TERM" == "xterm-kitty" ]; then
#   hash tmux && [ "$INPUTRC" != "~/.fig/nop" ] && [ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit; }
# fi

# bun
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
. "$HOME/.cargo/env"

# pnpm
export PNPM_HOME="/Users/coreyja/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# pnpm end
alias claude="/Users/coreyja/.claude/local/claude"
source ~/.local/share/blesh/ble.sh
