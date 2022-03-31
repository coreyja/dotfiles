[ -n "$PS1" ] && source ~/.bashrc;

# Export both brew paths
export PATH="/usr/local/bin:$PATH";
export PATH="/opt/homebrew/bin:$PATH";


BREW_PREFIX=$(brew --prefix)

# Add GnuCoreUtils to the Path
export PATH="$BREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="$BREW_PREFIX/opt/coreutils/libexec/gnubin:$MANPATH"
# Add grep to the Path
export PATH="$BREW_PREFIX/opt/grep/libexec/gnubin:$PATH"
export MANPATH="$BREW_PREFIX/opt/grep/libexec/gnubin:$MANPATH"
# Add sed to the Path
export PATH="$BREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
export MANPATH="$BREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"
# Add Cargo to Path
# Add Go bin dir to path
export PATH=$PATH:$(go env GOPATH)/bin

# No more dups in History
export HISTCONTROL=ignoreboth:erasedups

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if command -v brew &> /dev/null && [ -f "$BREW_PREFIX/share/bash-completion/bash_completion" ]; then
	source "$BREW_PREFIX/share/bash-completion/bash_completion";
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f "$BREW_PREFIX/etc/bash_completion.d/git-completion.bash" ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

# Add fzf to Bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
complete -F _fzf_file_completion -o default -o bashdefault rspec
complete -F _fzf_file_completion -o default -o bashdefault rake
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" 2> /dev/null'

# Add Tmux and tmuxinator bash completion
[ -f "$BREW_PREFIX/etc/bash_completion.d/tmux" ] && source "$BREW_PREFIX/etc/bash_completion.d/tmux"
[ -f ~/bash_completion.d/tmuxinator.bash ] && source ~/bash_completion.d/tmuxinator.bash
[ -f ~/bash_completion.d/muxed.bash ] && source ~/bash_completion.d/muxed.bash

# Init RBenv, pyenv and nodenv
command -v rbenv &> /dev/null && eval "$(rbenv init -)"

command -v pyenv &> /dev/null && eval "$(pyenv init -)" && export PYENV_ROOT="$(pyenv root)"

command -v nodenv &> /dev/null && eval "$(nodenv init -)"

# Init DirEnv
command -v direnv &> /dev/null && eval "$(direnv hook bash)"

 # Since v2.1 GnuPG have changed the method a daemon starts. They are all started
 # on demand now. For more information see:
 #   https://www.gnupg.org/faq/whats-new-in-2.1.html#autostart
 # Found this: https://www.linuxquestions.org/questions/slackware-14/gpg-agent-write-env-file-obsolete-4175608513/
GPG_TTY=$(/usr/bin/tty)
SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
export GPG_TTY SSH_AUTH_SOCK
gpgconf --launch gpg-agent

command -v starship &> /dev/null && eval "$(starship init bash)"

# Add `~/bin` and `~/.local/bin/` to the `$PATH`
# Do this at the end to take precedence over things above
export PATH="$HOME/bin:$PATH";
export PATH="$HOME/.local/bin:$PATH";

# Haskell
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

[ -f "/Users/coreyja/.config/broot/launcher/bash/br" ] && source /Users/coreyja/.config/broot/launcher/bash/br

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
command -v atuin &> /dev/null && eval "$(atuin init bash)"

# git diff before commit
function gg {
    PAGER="less -+F" br --conf ~/.config/broot/git-diff-conf.toml --git-status
}
. "$HOME/.cargo/env"
