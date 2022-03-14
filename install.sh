#!/bin/bash

#######
# vim #
#######
mkdir -p "$HOME"/.vim_runtime""
ln -sf "$HOME/dotfiles/vim/.vimrc" "$HOME/.vimrc"
rm -rf "$HOME/.vim_runtime"
ln -s "$HOME/dotfiles/vim/.vim_runtime" "$HOME"

#######
# X11 #
#######
rm -rf "$HOME/.config/X11"
ln -s "$HOME/dotfiles/X11" "$HOME/.config"

######
# i3 #
######

rm -rf "$HOME/.config/i3"
ln -s "$HOME/dotfiles/i3" "$HOME/.config"

#######
# zsh #
#######

mkdir -p "$HOME/.config/zsh"
ln -sf "$HOME/dotfiles/zsh/.zshenv" "$HOME"
ln -sf "$HOME/dotfiles/zsh/.zshrc" "$HOME/.config/zsh"
