" Nvim Key Bindings

" NERDTree Mappings 
" nnoremap <C-f> :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>


"""""""""""""""""""     Window Navigation """""""""""""""""
" Open Tag Bar
nmap <F8> :TagbarToggle<CR>

" Maps Alt-[h,j,k,l] to resizing a window split
map <silent> <A-Left> <C-w><
map <silent> <A-Down> <C-W>-
map <silent> <A-Up> <C-W>+
map <silent> <A-Right> <C-w>>

" Maps Alt-[s.v] to horizontal and vertical split respectively
map <silent> <A-s> :split<CR>
map <silent> <A-v> :vsplit<CR>

" Maps Alt-[n,p] for moving next and previous window respectively
map <silent> <A-n> <C-w><C-w>
map <silent> <A-p> <C-w><S-w>

" close the window 
map <silent> <A-q> <C-w>q


"""""""""""""""""""     Buffer Navigation """""""""""""""""
" Shows list of buffer and then enter the num to switch to it, Use <C-^> for
" going to previously edited buffer 
nnoremap <silent> <F5> :buffers<CR>:buffer<Space>
nnoremap <silent> <A-PageUp> :bn<CR>
nnoremap <silent> <A-PageDown> :bp<CR>

" quit buffer
nnoremap <silent> <A-S-q> :bd<CR>

