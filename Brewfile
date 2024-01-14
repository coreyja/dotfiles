def group(_name, &block)
  yield
end

cask_args appdir: "~/Applications"

tap 'thoughtbot/formulae'

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
group 'GNU core utilities and replacements' do
  brew 'coreutils'
  brew 'gnu-sed'
  brew 'grep'
  brew 'moreutils'
  brew 'findutils'

  tap 'burntsushi/ripgrep', 'https://github.com/BurntSushi/ripgrep.git'
  brew 'ripgrep-bin'

  brew 'fd' # Find replacement

  brew 'gcal'
end

group 'Git utilities' do
  brew 'git'
  brew 'gitsh'
  brew 'git-lfs'
  brew 'git-delta'
  brew 'gh'
end

group 'Version Managers' do
  brew 'ruby-build'
  brew 'rbenv'
  brew 'node-build'
  brew 'nodenv'
  brew 'pyenv'
  brew 'asdf'
  brew 'tig'
end

brew 'bash'
# brew 'bash-completion2'

brew 'wget'

brew 'grep'
brew 'openssh'
brew 'screen'

brew 'ack'
brew 'imagemagick'
brew 'lua'
brew 'p7zip'
brew 'pigz'
brew 'webkit2png'
brew 'tree'
brew 'pgcli'
brew 'ffmpeg'
brew 'awscli'
brew 'direnv'
brew 'bat'
brew 'hyperfine' # Benchmarking tool
brew 'asciinema'
brew 'blink1'
brew 'ncdu'
brew 'httpie'
brew 'flyctl'
brew 'pango'

# Needed for Rustc
brew 'cmake'
brew 'ninja'

# GNU Calendar to replace cal

# FZF
brew 'fzf'

# Fun Stuff with No Purpose
brew 'cowsay'
brew 'figlet'
brew 'fortune'
brew 'no-more-secrets'
brew 'watch'
brew 'asciiquarium'

# Tmux
brew 'tmux'
brew 'reattach-to-user-namespace'
brew 'rainbarf'

# Security/Yubikey Stuff
brew 'gpg'
brew 'pinentry-mac'
brew 'ykman'

# Vim Stuff
brew 'nvim'
brew 'editorconfig'
brew 'vale'
brew 'python'

# TLDR Man Pages
brew 'tealdeer'

brew 'nnn'

brew 'rustup'

brew 'go'
brew 'gopls'

brew 'knqyf263/pet/pet'

brew 'yarn'
brew 'task'

brew 'hurl'
brew 'glow'

tap 'brianp/homebrew-muxed'
brew 'brianp/homebrew-muxed/muxed_bin'

brew 'caddy'
brew 'nss'

cask 'paintbrush'
cask 'alfred'
cask 'vlc'
cask 'openshot-video-editor'
cask 'alacritty'
cask 'kitty'
cask 'pock'
cask 'dash'
cask 'ngrok'

cask 'obs-websocket'

cask 'obsidian'

cask '1password-cli'

cask 'docker'

cask 'notunes'

# Install Hack Nerd Font
tap 'homebrew/cask-fonts'
cask 'homebrew/cask-fonts/font-hack-nerd-font'
cask 'homebrew/cask-fonts/font-victor-mono-nerd-font'
cask 'homebrew/cask-fonts/font-victor-mono'
