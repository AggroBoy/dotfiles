# General settings
unsetopt beep
bindkey -v
set -o EXTENDEDGLOB

# Color ls
if [[ $(uname) == "Darwin" ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color'
fi

# Make less accept colour
export LESS='-R'

# Stop zsh trying to parse rake arguments
alias rake='noglob rake'

# The prompt
export PS1='%B%* [%m %~] %h%#%b '

# completion settings
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _match _approximate _prefix
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=10
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/goringw/.zshrc'

autoload -Uz compinit
compinit


# Import the machine specific settings
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
else
    echo "# Machine-specific zsh settings; will override .zshrc" > ~/.zshrc.local
    echo "# NOT under source control" >> ~/.zshrc.local
fi

