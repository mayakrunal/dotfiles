" Set the initial variables
set encoding=UTF-8
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set autoindent
colorscheme default

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#begin()

" Fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Status bar & Themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'tpope/vim-fugitive'

" Tag outlines
Plug 'preservim/tagbar'

" Linters
Plug 'dense-analysis/ale'

" Terminal File Manafer with floaters
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'

" Language Server Protocol
Plug 'neovim/nvim-lspconfig'

" Code completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

" Snips
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'
call plug#end()

" Airline Options
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_detect_modified = 1

" Ale Configuration
let g:ale_fixers = {'javascript':['prettier','eslint'],'ccp':['clang-format']}
let g:ale_fix_on_save = 1

set completeopt=menu,menuone,noselect

" Key Mappings
nmap <F8> :TagbarToggle<CR>

" Map Leader Key
nnoremap <SPACE> <Nop>
let mapleader = " "
