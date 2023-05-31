let mapleader = ","         " Set leader key to comma 
set number                  " Line numbers
set relativenumber          " Relative numbers
set nocompatible	        " disable comptibility to old-time vi
set showmatch		        " show matching
set ignorecase		        " case insensitive
set mouse=v	    	        " middle click paste
set hlsearch		        " highlight search
set incsearch		        " incremental search
set tabstop=4		        " number of column occcupied by a tab
set softtabstop=4	        " see multiple spaces as tabstops
set expandtab		        " converts tabs to whitespace
set smarttab                " use smarttabs 
set shiftwidth=4	        " width for autoindents
set autoindent		        " indent a newline the same amount as the line just typed
filetype plugin indent on   " auto indent depending on file type
syntax on		            " syntax highlighting
set mouse=a		            " enable mouseclick
" set cursorline		        " highlight current curosor line
set ttyfast		            " speed up scrolling in vim

call plug#begin()

Plug 'vim-airline/vim-airline'                      " status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'                           " File explorer in nvim
Plug 'tpope/vim-surround'                           " Surround operations ysw)
Plug 'tpope/vim-commentary'                         " For commentary gcc & gc
Plug 'ap/vim-css-color'                             " Preview CSS colors
Plug 'tc50cal/vim-terminal'                         " Terminal inside nvim
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " Multi curosor ctrl + N
Plug 'preservim/tagbar'                             " Tagbar on right side for code navigation
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " Code completion
Plug 'ryanoasis/vim-devicons'                       " Developers Icons

call plug#end()

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

let g:airline#extensions#tabline#enabled = 1

" souce the configurations that are in separate files
source coc_func.vim
source keybindings.vim
