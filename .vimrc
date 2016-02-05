" Pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on

" solarized
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" fix tmux colors
set t_ut=

" tab to spaces
:set tabstop=4 shiftwidth=4 expandtab

" autoremove trailing spaces
autocmd BufWritePre * :%s/\s\+$//e

" Highlight search
set hls

" Syntastic configuration
let g:syntastic_python_checkers = ['flake8', 'pylint', 'pep8']
