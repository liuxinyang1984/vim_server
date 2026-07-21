" Autocommands (non-plugin).

if has('autocmd')
  augroup vim_server_restore_cursor
    autocmd!
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   execute "normal! g`\"" |
          \ endif
  augroup END
endif
