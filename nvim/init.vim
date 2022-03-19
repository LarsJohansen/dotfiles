set clipboard+=unnamedplus

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

set noswapfile

" save undo-trees in files
set undofile
set undodir=$HOME/.config/nvim/undo
set undolevels=10000
set undoreload=10000

" set line number 
set number

" spaces/indent
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
