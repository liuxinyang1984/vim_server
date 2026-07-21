" Keymaps (plugin maps OK; add new Plug only in plugin-manager.vim).

nnoremap <Esc> :nohlsearch<CR>

imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
imap <C-d> <Esc>ddi
imap <C-D> <Esc>Di
imap <C-u> <Esc>u
imap <C-r> <Esc><C-r>
imap <C-BS> <C-o>d0

nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>
nnoremap <C-q> :q<CR>
inoremap <C-q> <Esc>:q<CR>

nnoremap tn :tabe<CR>
nnoremap th :tabp<CR>
nnoremap tl :tabn<CR>
nnoremap tk :-tabmove<CR>
nnoremap tj :+tabmove<CR>

nnoremap J 5j
nnoremap K 5k
vnoremap J 5j
vnoremap K 5k

nnoremap wh <C-w>h
nnoremap wj <C-w>j
nnoremap wk <C-w>k
nnoremap wl <C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap <A-H> :vertical resize +5<CR>
nnoremap <A-L> :vertical resize -5<CR>
nnoremap <A-J> :resize +5<CR>
nnoremap <A-K> :resize -5<CR>
nnoremap sl :set splitright<CR>:vsplit<CR>
nnoremap sh :set nosplitright<CR>:vsplit<CR>
nnoremap sj :set splitbelow<CR>:split<CR>
nnoremap sk :set nosplitbelow<CR>:split<CR>

nnoremap tt :NERDTreeToggle<CR>

" wildfire: expand text object inside quotes/brackets (Normal mode)
nmap <CR> <Plug>(wildfire-fuel)

" Leaderf (ff/fr/fb/fm)
nnoremap ff :Leaderf file<CR>
nnoremap fr :Leaderf rg<CR>
nnoremap fb :Leaderf buffer<CR>
nnoremap fm :Leaderf mru<CR>

nmap <C-/> <Plug>NERDCommenterComment
vmap <C-/> <Plug>NERDCommenterComment

nnoremap <leader>tm :TableModeToggle<CR>
nnoremap <leader>tr :TableModeRealign<CR>
nnoremap <leader>ti :TableModeTableize<CR>

iabbrev ddd <C-r>=strftime("%Y-%m-%d")<CR>
iabbrev dddd <C-r>=strftime("%Y-%m-%d %H:%M:%S")<CR>
