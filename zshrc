# General settings
unsetopt beep
bindkey -v
set -o EXTENDEDGLOB

# Make less accept colour
export LESS='-R'

# Stop zsh trying to parse rake arguments
alias rake='noglob rake'

# The prompt
export PS1="
%B%* [%m %~] %h%#%b "

# ls colours
export LS_COLORS="da=32:di=34:ux=35:ex=35:ln=33"

# Turn off history
unset HISTFILE

# Import the machine specific settings
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
else
    echo "# Machine-specific zsh settings; will override .zshrc" > ~/.zshrc.local
    echo "# NOT under source control" >> ~/.zshrc.local
fi

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

# Improved / alternate command replacements
if [[ -f $(whence exa) ]]; then
    alias ls="exa";
    export EXA_COLORS="reset:$LS_COLORS"
else
    # No exa, so at least make ls be colour
    if [[ $(uname) == "Darwin" ]]; then
        alias ls='ls -G'
    else
        alias ls='ls --color'
    fi
fi

# The lscolors library that fd uses does't have a `reset` like exa, so have to be creative to
# remove it's built-in defaults. Also, use a more subtle prefix-dir colour than the standard
# ls dir colour
alias fd='LS_COLORS="*=05:$LS_COLORS:di=33" fd'

