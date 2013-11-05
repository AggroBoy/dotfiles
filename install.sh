#!env zsh

# A function to link a file from this directory as a dotfile in the user's $HOME
# Assumes that the file should have the same name with a '.' prepended.
makelink () {
    if [[ -h $HOME/.$1 ]] then
	rm $HOME/.$1
    elif [[ -e $HOME/.$1 ]]; then
        mv $HOME/.$1 $HOME/.backups
    fi
    ln -s $DIR/$1 $HOME/.$1
}

# Get the dotfiles directory
DIR=$(dirname $0)

# Create a backups directory to put old files in
# my vim config uses this too, so it's good to make sure it's there.
mkdir -p $HOME/.backups

# Make the links
makelink zshrc
makelink vimrc

