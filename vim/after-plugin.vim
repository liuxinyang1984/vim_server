" Plugin settings (after plug#end). No Plug lines here.

set background=dark
silent! colorscheme gruvbox
let g:gruvbox_italic = 1

let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 0

let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeShowLineNumbers = 1

let g:table_mode_map_prefix = '<Leader>t'

" indentLine
let g:indentLine_enabled = 1
let g:indentLine_char = '|'
let g:indentLine_faster = 1
let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'leaderf']

" LeaderF (needs +python or +python3; fr needs ripgrep on PATH)
let g:Lf_WorkingDirectoryMode = 'Auto'
let g:Lf_ShowRelativePath = 1
let g:Lf_UseMemoryCache = 0

" rainbow (bracket colors)
let g:rainbow_active = 1

" auto-pairs: insert closing ), ], }, ', "
let g:AutoPairsFlyMode = 1

command! Sw SudaWrite
cnoreabbrev sw SudaWrite
