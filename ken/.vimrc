call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'
call plug#end()

set encoding=UTF-8
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set autoindent


"Enable the Tab line
let g:airline#extensions#tabline#enabled = 1
"Need cool symbols
let g:airline_powerline_fonts = 1
let g:airline_detect_modified = 1
