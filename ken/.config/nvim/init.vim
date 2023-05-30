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
set smarttab
set shiftwidth=4	        " width for autoindents
set autoindent		        " indent a newline the same amount as the line just typed
" set wildmode=longest,list   " get bash like completion
" set cc=80		            " set an 80 column border for good coding style
filetype plugin indent on   " auto indent depending on file type
syntax on		            " syntax highlighting
set mouse=a		            " enable mouseclick
set cursorline		        " highlight current curosor line
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

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>


let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

let g:airline#extensions#tabline#enabled = 1

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"


" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

