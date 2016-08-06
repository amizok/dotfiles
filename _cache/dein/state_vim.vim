let [plugins, ftplugin] = dein#load_cache_raw(['/Users/kei/.vimrc', '/Users/kei/.dein.toml'], 1)
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/kei/.cache/dein'
let g:dein#_runtime_path = '/Users/kei/.cache/dein/.dein'
let &runtimepath = '/Users/kei/.cache/dein/repos/github.com/Shougo/vimproc.vim,/Users/kei/.cache/dein/.dein,/Users/kei/.cache/dein/repos/github.com/Shougo/dein.vim,/Users/kei/.vim,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim74,/usr/local/share/vim/vimfiles/after,/Users/kei/.vim/after,/Users/kei/.cache/dein/.dein/after'
  set background=dark
  au MyAutoCmd VimEnter * nested colorscheme hybrid
