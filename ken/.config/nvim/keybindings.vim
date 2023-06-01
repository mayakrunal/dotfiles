" Nvim Key Bindings

" NERDTree Mappings 
" nnoremap <C-f> :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTree<CR>
" nnoremap <C-t> :NERDTreeToggle<CR>

" Terminal bindings
:tnoremap <Esc> <C-\><C-n>
nnoremap <leader>t <cmd>belowright split term://zsh<cr>


" Neo Tree bindings
nnoremap <leader>/ <cmd>Neotree reveal<cr>
nnoremap <leader>. <cmd>Neotree git_status float toggle<cr>

" Telescope shortcuts 
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


"""""""""""""""""""     Window Navigation """""""""""""""""
" Open Tag Bar
nmap <F8> :TagbarToggle<CR>

" Maps Alt-[h,j,k,l] to resizing a window split
map <silent> <A-S-Left> <C-w><
map <silent> <A-S-Down> <C-W>-
map <silent> <A-S-Up> <C-W>+
map <silent> <A-S-Right> <C-w>>

" Maps Alt-[s.v] to horizontal and vertical split respectively
map <silent> <A-s> :split<CR>
map <silent> <A-v> :vsplit<CR>

" Maps Alt-[left,right] for moving next and previous window respectively
map <silent> <A-Right> <C-w><C-w>
map <silent> <A-Left> <C-w><S-w>
map <silent> <A-Up> <C-w><C-w>
map <silent> <A-Down> <C-w><S-w>

" close the window 
map <silent> <A-z> <C-w>q


"""""""""""""""""""     Buffer Navigation """""""""""""""""
" Shows list of buffer and then enter the num to switch to it, Use <C-^> for
" going to previously edited buffer
" (using telescope buffers is better)
" nnoremap <silent> <F5> :buffers<CR>:buffer<Space> 
nnoremap <silent> <A-PageUp> :bn<CR>
nnoremap <silent> <A-PageDown> :bp<CR>

" quit buffer
nnoremap <silent> <A-q> :bd<CR>

