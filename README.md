# Coreyja's dotfiles

My dotfiles!

This started out as a fork from https://github.com/mathiasbynens/dotfiles but diverged enough that I cut the fork tie at some point.

Notably I run my dotfiles where my homedir is under git, so not aliasing/copying is required or provided here

Here are some blog posts I've written about my dotfiles:
- https://coreyja.com/dotfiles-git-in-home-dir/
- https://coreyja.com/upgrading-to-brew-2/
- https://coreyja.com/dotfiles-december-2018/


## Setup

Doing setup on a new machine so writing some documentation

### Using `brew` installed `bash`

To update the shell we need to do two things both need root perms:
 - Add `$(brew prefix)/bin/bash` to `/etc/shells` so its an allowed shell
 - Run `sudo chsh -s "$(brew prefix)/bin/bash"` to set it as the default shell for the user
