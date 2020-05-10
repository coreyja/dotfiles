[ -n "$PS1" ] && source ~/.bashrc;

# Add `~/bin` and `~/.local/bin/` to the `$PATH`
export PATH="$HOME/bin:$PATH";
export PATH="$HOME/.local/bin:$PATH";
export PATH="/usr/local/bin:$PATH";
# Add GnuCoreUtils to the Path
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnubin:$MANPATH"
# Add grep to the Path
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/grep/libexec/gnubin:$MANPATH"
# Add sed to the Path
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
# Add Cargo to Path
export PATH="$HOME/.cargo/bin:$PATH"
# Add Go bin dir to path
export PATH=$PATH:$(go env GOPATH)/bin

# No more dups in History
export HISTCONTROL=ignoreboth:erasedups

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
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
if command -v brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

# Enable AutoJump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Add fzf to Bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
complete -F _fzf_file_completion -o default -o bashdefault rspec
complete -F _fzf_file_completion -o default -o bashdefault rake
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" 2> /dev/null'

# Add Tmux and tmuxinator bash completion
[ -f /usr/local/etc/bash_completion.d/tmux ] && source /usr/local/etc/bash_completion.d/tmux
[ -f ~/bash_completion.d/tmuxinator.bash ] && source ~/bash_completion.d/tmuxinator.bash

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
