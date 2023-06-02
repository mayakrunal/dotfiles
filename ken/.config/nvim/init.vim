let mapleader = " "         " Set leader key to space 
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
" set cursorline		    " highlight current curosor line
set ttyfast		            " speed up scrolling in vim


" Plugins for neovim 
call plug#begin()
    
    Plug 'vimwiki/vimwiki'                              " Vim wiki

    "tpope's useful pluginsxported from Evernote via .enex fi
    Plug 'tpope/vim-fugitive'                           " git commands in vim
    Plug 'tpope/vim-surround'                           " Surround operations ysw)
    Plug 'tpope/vim-commentary'                         " For commentary gcc & gc
    
    " Airline
    Plug 'vim-airline/vim-airline'                      " status bar
    Plug 'vim-airline/vim-airline-themes'               " Air line themes
    
    Plug 'ap/vim-css-color'                             " Preview CSS colors
    Plug 'mg979/vim-visual-multi', {'branch': 'master'} " Multi curosor ctrl + N
    Plug 'preservim/tagbar'                             " Tagbar on right side for code navigation
    
    Plug 'farmergreg/vim-lastplace'                     " Remeber the last place for file if you reopen it
   
    " Telescope setup
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }

    " Syntax Highlight
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " Neo Tree (file system tree sidebar)
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'MunifTanjim/nui.nvim'
    Plug 'nvim-neo-tree/neo-tree.nvim'

    " One dark theme
    Plug 'navarasu/onedark.nvim'
    " LSP Support
    Plug 'neovim/nvim-lspconfig'                           " Required
    Plug 'williamboman/mason.nvim', {'do': ':MasonUpdate'} " Optional
    Plug 'williamboman/mason-lspconfig.nvim'               " Optional

    " Autocompletion
    Plug 'hrsh7th/nvim-cmp'     " Required
    Plug 'hrsh7th/cmp-nvim-lsp' " Required
    Plug 'L3MON4D3/LuaSnip'     " Required

    Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}

    " Debug Adapter protocol for debugging capabilities
    Plug 'mfussenegger/nvim-dap'
    " Debug Adapter protocol ui
    Plug 'rcarriga/nvim-dap-ui'
    " go debugger
    Plug 'leoluz/nvim-dap-go'  
    " python debugger
    Plug 'mfussenegger/nvim-dap-python'

call plug#end()

let g:tagbar_position = 'left'
let g:onedark_config = {'style': 'deep',}

colorscheme onedark


" souce the configurations that are in separate files
source ~/.config/nvim/airline.vim
source ~/.config/nvim/neotree.lua
source ~/.config/nvim/nvim-treesitter.lua
source ~/.config/nvim/lsp.lua
source ~/.config/nvim/dap.lua
source ~/.config/nvim/keybindings.vim
