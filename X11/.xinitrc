# source "$HOME/dotfiles/zsh/.zshrc"
xrdb -merge $HOME/.config/X11/.Xresources
urxvtd -o -q -f
udiskie &

setxkbmap no
# setxkbmap -option 'caps:ctrl_modifier';xcape -e 'Caps_Lock=Escape'&

setxkbmap -option caps:escape

exec i3
source "$HOME/zsh/.zshrc"
