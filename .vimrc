"==========================================
" プラグイン管理(dein.vim)
"==========================================
if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" dein settings -----------------
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/.dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
" 依存関係がある場合
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" -------------------------------

"==========================================
" 画面表示の設定
"==========================================
syntax on           " コードに色をつける
set number          " 行番号を表示する
set cursorline      " カーソル行の背景色を変える
set laststatus=2    " ステータス行を常に表示
set cmdheight=2     " メッセージ表示欄を2行確保
set showmatch       " 対応する括弧を強調表示
set helpheight=999  " ヘルプを画面いっぱいに開く
set tabstop=4
set list            " 不可視文字を表示
set t_Co=256        " 256色を使う
" 不可視文字の表示記号指定
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
" deleteキーが効かない対応
set backspace=indent,eol,start

" ヤンクをクリップボードへ送り込む
set clipboard+=unnamed
" ステータスにファイル情報表示
set statusline=%<[%n]%F%=\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}\ %l,%c\ %P

"==========================================
" 各プラグインの設定
"==========================================
"--------------------------------
" ctags
"--------------------------------
" 拡張子で読み込みタグ変更
au BufNewFile,BufRead *.php set tags+=$HOME/php.tags
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>

"--------------------------------
" taglist
"--------------------------------
:set tag=tags
let Tlist_Show_One_File    = 1 " 現在表示中のファイルのみのタグしか表示しない
let Tlist_Use_Right_Window = 1 " 右側にtag listのウインドうを表示する
let Tlist_Exit_OnlyWindow  = 1 " taglistのウインドウだけならVimを閉じる
" \lでtaglistウインドウを開いたり閉じたり出来るショートカット
map <silent> <leader>l :TlistToggle<CR>

"--------------------------------
" unite.vim
"--------------------------------
" insert modeで開始
let g:unite_enable_start_insert = 1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" 大文字小文字を区別しない
let g:unite_enable_ignore_case  = 1
let g:unite_enable_smart_case   = 1

" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command       = 'ag'
  let g:unite_source_grep_default_opts  = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

"--------------------------------
" vim-fugitive'
"--------------------------------
" grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow
" ステータス行に現在のgitブランチを表示する
set statusline+=%{fugitive#statusline()}

"--------------------------------
" vim-gitgutter
"--------------------------------
" 差分表示を250ミリ秒に設定
set updatetime=250

let g:gitgutter_sign_modified = '■'
let g:gitgutter_sign_removed  = '-'
let g:gitgutter_max_signs = 500

"--------------------------------
" accelerated-jk
"--------------------------------
" j/kによる移動を速くする
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

"==========================================
" alias
"==========================================
:command Tr NERDTree

