#!env zsh

realpath() {
  OURPWD=$PWD
  cd "$(dirname "$1")"
  LINK=$(readlink "$(basename "$1")")
  while [ "$LINK" ]; do
    cd "$(dirname "$LINK")"
    LINK=$(readlink "$(basename "$1")")
  done
  REALPATH="$PWD/$(basename "$1")"
  cd "$OURPWD"
  echo "$REALPATH"
}

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


# Where are the dotfiles going? ($HOME of course)
TARGETDIR=$HOME

# Get the dotfiles directory
SOURCEDIR=$(realpath $(dirname $0))
echo $SOURCEDIR
SOURCEDIR=$(echo $SOURCEDIR | sed -e "s|/.$||")
SOURCEDIR=$(echo $SOURCEDIR | sed -e "s|^$TARGETDIR/||")

# Create a backups directory to put old files in
# my vim config uses this too, so it's good to make sure it's there.
mkdir -p $TARGETDIR/.backups

# Make the links
makelink zshrc
makelink vimrc

