" vim-plug bootstrap + plugin list ONLY (add new plugins here).

let s:dir = g:vim_config_dir
let s:plug_file = s:dir . '/autoload/plug.vim'

if empty(glob(s:plug_file))
  silent execute '!curl -fsSL https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim --create-dirs -o ' . shellescape(s:plug_file)
  autocmd VimEnter * !sleep 1
endif
execute 'source ' . fnameescape(s:plug_file)

call plug#begin(s:dir . '/plugged')

" NERDTree h/l (must be set before plug loads nerdtree)
let g:NERDTreeMapActivateNode = 'l'
let g:NERDTreeMapCloseDir       = 'h'
let g:NERDTreeMapCustomOpen     = '<CR>'
let g:NERDTreeQuitOnOpen        = 1

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'dhruvasagar/vim-table-mode'
Plug 'lambdalisue/suda.vim'
Plug 'gcmt/wildfire.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'
" Plug 'Ygg159/LeaderF'
Plug 'Yggdroot/LeaderF', { 'tag': 'v1.25', 'do': ':LeaderfInstallCExtension' }
Plug 'luochen1990/rainbow'
Plug 'junegunn/vim-peekaboo'

call plug#end()
