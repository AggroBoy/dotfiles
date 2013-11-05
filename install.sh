#!env zsh

# Where are the dotfiles going? ($HOME of course)
TARGETDIR=$HOME

# Get the dotfiles directory
SOURCEDIR=$(realpath --relative-to=$TARGETDIR $(dirname $0))


# A function to link a file from this directory as a dotfile in the user's $HOME
# Assumes that the file should have the same name with a '.' prepended.
makelink () {
    SOURCE=$SOURCEDIR/$1
    TARGET=$TARGETDIR/.$1

    if [[ -h $TARGET ]] then
	rm $TARGET
    elif [[ -e $TARGET ]]; then
        mv $TARGET $HOME/.backups
    fi
    ln -s $SOURCE $TARGET
}


# Create a backups directory to put old files in
# my vim config uses this too, so it's good to make sure it's there.
mkdir -p $TARGETDIR/.backups

# Make the links
makelink zshrc
makelink vimrc

