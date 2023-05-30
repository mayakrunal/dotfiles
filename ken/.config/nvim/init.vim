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
set shiftwidth=4	        " width for autoindents
set autoindent		        " indent a newline the same amount as the line just typed
set wildmode=longest,list   " get bash like completion
" set cc=80		            " set an 80 column border for good coding style
filetype plugin indent on   " auto indent depending on file type
syntax on		            " syntax highlighting
set mouse=a		            " enable mouseclick
set cursorline		        " highlight current curosor line
set ttyfast		            " speed up scrolling in vim


call plug#begin()


call plug#end()
