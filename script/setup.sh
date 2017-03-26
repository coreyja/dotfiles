rsync --exclude ".git/" \
	--exclude ".DS_Store" \
	--exclude ".osx" \
	--exclude "bootstrap.sh" \
	--exclude "README.md" \
	--exclude "LICENSE-MIT.txt" \
	--exclude "script/" \
	-avh --no-perms . ~;
source ~/.bash_profile;
