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

linkhome () {
    SOURCE=$SOURCEDIR/$1
    TARGET=$TARGETDIR/.$1
    
    makelink $SOURCE $TARGET
}

linkconfig () {
    SOURCE=$1
    TARGET=$TARGETDIR/.config/$(basename $1)

    makelink $SOURCE $TARGET
}

makelink() {
    SOURCE=$1
    TARGET=$2

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
QUALIFIED_SOURCEDIR=$(realpath $(dirname $0))
QUALIFIED_SOURCEDIR=$(echo $QUALIFIED_SOURCEDIR | sed -e "s|/.$||")
SOURCEDIR=$(echo $QUALIFIED_SOURCEDIR | sed -e "s|^$TARGETDIR/||")

# Create a backups directory to put old files in
# my vim config uses this too, so it's good to make sure it's there.
mkdir -p $TARGETDIR/.backups

# Many more modern utils keep their config in ~/.config, so make sure it's there
mkdir -p $TARGETDIR/.config


# Make the links
################

# homedir
linkhome zshrc
linkhome vimrc

# .config
for FILE in $QUALIFIED_SOURCEDIR/config/*; do
    linkconfig $FILE
done

