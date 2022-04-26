#!/bin/bash

########
# nvim #
########
mkdir -p "$XDG_CONFIG_HOME/nvim"
mkdir -p "$XDG_CONFIG_HOME/nvim/undo"
ln -sf "$DOTFILES/nvim/init.vim" "$XDG_CONFIG_HOME/nvim/init.vim"

# install neovim plugin manager
[ ! -f "$DOTFILES/nvim/autoload/plug.vim" ] \
&& curl -fLo "$DOTFILES/nvim/autoload/plug.vim" --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p "$XDG_CONFIG_HOME/nvim/autoload"
ln -sf "$DOTFILES/nvim/autoload/plug.vim" "$XDG_CONFIG_HOME/nvim/autoload/plug.vim"
# Install (or update) all the plugins
nvim --noplugin +PlugUpdate +qa

#######
# vim #
#######
# mkdir -p "$HOME"/.vim_runtime""
# ln -sf "$DOTFILES/vim/.vimrc" "$HOME/.vimrc"
# rm -rf "$HOME/.vim_runtime"
# ln -s "$DOTFILES/vim/.vim_runtime" "$HOME"

#######
# X11 #
#######
rm -rf "$XDG_CONFIG_HOME/X11"
ln -s "$DOTFILES/X11" "$XDG_CONFIG_HOME"
ln -sf "$DOTFILES/X11/.xinitrc" "$HOME"

######
# i3 #
######

rm -rf "$XDG_CONFIG_HOME/i3"
ln -s "$DOTFILES/i3" "$XDG_CONFIG_HOME"

#######
# zsh #
#######

mkdir -p "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/.zshenv" "$HOME"
ln -sf "$DOTFILES/zsh/.zshrc" "$XDG_CONFIG_HOME/zsh"

ln -sf "$DOTFILES/zsh/aliases" "$XDG_CONFIG_HOME/zsh/aliases"
rm -rf "$XDG_CONFIG_HOME/zsh/external"
ln -sf "$DOTFILES/zsh/external" "$XDG_CONFIG_HOME/zsh"

#########
# picom #
#########

# ln -sf "$DOTFILES/picom/picom.conf" "$XDG_CONFIG_HOME/picom/picom.conf"

#########
# emacs #
#########
mkdir -p "$HOME/.emacs.d"
ln -sf "$DOTFILES/emacs/custom.el" "$HOME/.emacs.d/"
ln -sf "$DOTFILES/emacs/init.el" "$HOME/.emacs.d/"

#########
# Fonts #
#########

mkdir -p "$XDG_DATA_HOME"
cp -rf "$DOTFILES/fonts" "$XDG_DATA_HOME"

#########
# Dunst #
#########
mkdir -p "$XDG_CONFIG_HOME/dunst"
ln -sf "$DOTFILES/dunst/dunstrc" "$XDG_CONFIG_HOME/dunst/dunstrc"

########
# tmux #
########
mkdir -p "$XDG_CONFIG_HOME/tmux"
ln -sf "$DOTFILES/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"

[ ! -d "$XDG_CONFIG_HOME/tmux/plugins/tpm" ] \
&& git clone https://github.com/tmux-plugins/tpm \
"$XDG_CONFIG_HOME/tmux/plugins/tpm"

############
# redshift #
############
ln -sf $DOTFILES/redshift/redshift.conf $XDG_CONFIG_HOME

#######
# feh #
#######
ln -sf $DOTFILES/feh/.fehbg $XDG_CONFIG_HOME/.fehbg
