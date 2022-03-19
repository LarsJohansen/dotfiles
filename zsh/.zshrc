fpath=($ZDOTDIR/external $fpath)

# source "$HOME/dotfiles/zsh/.zshenv"
source "$XDG_CONFIG_HOME/zsh/aliases"

setopt AUTO_PARAM_SLASH
unsetopt CASE_GLOB

# Navigate completion menu with vim keys
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
autoload -U compinit; compinit

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

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

source ~/dotfiles/zsh/external/bd.zsh

if [ $(command -v "fzf") ]; then
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
fi

# start i3
if [ "$(tty)" = "/dev/tty1" ];
then
    pgrep i3 || exec startx "$HOME/.xinitrc"
fi

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
