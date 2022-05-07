fpath=($ZDOTDIR/external $fpath)

# source "$HOME/dotfiles/zsh/.zshenv"
source "$XDG_CONFIG_HOME/zsh/aliases"
source "$DOTFILES/zsh/scripts.sh"

setopt AUTO_PARAM_SLASH
unsetopt CASE_GLOB

# SCRIPTS
# ftmuxp


# Navigate completion menu with vim keys
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
autoload -U compinit; compinit

# Ctrl+G to clear screen (to be compatible with tmux)
bindkey -r '^l'
bindkey -r '^g'
bindkey '^g' .clear-screen

# Autocomplete hidden files 
_comp_options+=(globdots)
source ~/dotfiles/zsh/external/completion.zsh

# Fix prompt
autoload -Uz prompt_purification_setup; prompt_purification_setup

# Directory stack
# Push the current directory visited on to the stack 
setopt AUTO_PUSHD
# Do not store duplicate directories in the stack
setopt PUSHD_IGNORE_DUPS
# Do not print the directory stack after using pushd or popd
setopt PUSHD_SILENT

# Vim
bindkey -v
export KEYTIMEOUT=1
# Set vim cursor mode
autoload -Uz cursor_mode && cursor_mode
# Set diffprog
export DIFFPROG="nvim -d $1"

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

source ~/dotfiles/zsh/external/bd.zsh

if [ $(command -v "fzf") ]; then
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
fi

eval "$(pyenv virtualenv-init -)"
eval "$(pyenv init -)"

# nnn cd on quit
n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# start i3
if [ "$(tty)" = "/dev/tty1" ];
then
    pgrep i3 || exec startx "$HOME/.xinitrc"
fi


source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
