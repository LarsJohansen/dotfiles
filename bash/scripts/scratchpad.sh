tmux kill-session -t scratchpad
urxvt -name URxvt_scratchpad -e tmux new-session -d -s scratchpad \; new-window -n vim 'nvim +e /tmp/nvim-tmp.md' \; attach-session -d -t scratchpad
