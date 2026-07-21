" vim-server entry (CentOS 7 / Vim 7.4). All config under vim/.
" Deploy: put "source /opt/vim-config/vimrc" in ~/.vimrc (do not symlink).

let g:vim_config_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

execute 'source ' . fnameescape(g:vim_config_dir . '/vim/plugin-manager.vim')
execute 'source ' . fnameescape(g:vim_config_dir . '/vim/settings.vim')
execute 'source ' . fnameescape(g:vim_config_dir . '/vim/after-plugin.vim')
execute 'source ' . fnameescape(g:vim_config_dir . '/vim/maps.vim')
execute 'source ' . fnameescape(g:vim_config_dir . '/vim/autocmds.vim')
