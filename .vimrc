"==========================================
" プラグインセットアップ(dein.vim)
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
" 各種オプションの設定
"==========================================
set title                     " ターミナルにファイル名を表示
set number                    " 行番号を表示する
set cursorline                " カーソル行の背景色を変える
set laststatus=2              " ステータス行を常に表示
set cmdheight=2               " メッセージ表示欄を2行確保
set showmatch                 " 対応する括弧を強調表示
set helpheight=999            " ヘルプを画面いっぱいに開く

" 検索系
set hlsearch                  " 検索結果をハイライト
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" タブの設定
set expandtab                 " タブ入力を複数の空白入力に置き換える
set tabstop=4                 " タブ文字の表示幅
set shiftwidth=4              " Vimが挿入するインデントの幅
set softtabstop=4
set autoindent
set smartindent

set visualbell t_vb=          " Beep音を消す

syntax on                     " 構文毎に文字色を変化させる
set t_Co=256                  " 256色を使う

set list                      " 不可視文字を表示
" 不可視文字の表示記号指定
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
" スワップファイルを作成しない
:set noswapfile

set backspace=indent,eol,start " deleteキーが効かない対応
set whichwrap=b,s,h,l,<,>,[,]  " カーソルを行頭、行末で止まらないようにする
set clipboard+=unnamed         " ヤンクをクリップボードへ送り込む

" ステータスにファイル情報表示
set statusline=%<[%n]%F%=\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}\ %l,%c\ %P

" マッピング
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>
nnoremap Y y$

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

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
" GNU GLOBAL(gtags)
"--------------------------------
"検索結果Windowを閉じる
nmap <C-q> <C-w><C-w><C-w>q
"ソースコードの grep
nmap <C-g> :Gtags -g
"このファイルの関数一覧
nmap <C-l> :Gtags -f %<CR>
"カーソル以下の定義元を探す
nmap <C-j> :Gtags <C-r><C-w><CR>
"カーソル以下の使用箇所を探す
nmap <C-k> :Gtags -r <C-r><C-w><CR>
"次の検索結果へジャンプする
nmap <C-n> :cn<CR>
"前の検索結果へジャンプする
nmap <C-p> :cp<CR>

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
noremap <C-Q> :Unite file_mru<CR>
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
" vim-fugitive
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

"--------------------------------
" lightline.vim
"--------------------------------
let g:lightline = {
     \ 'colorscheme': 'default',
     \ 'active': {
     \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
     \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
     \ },
     \ 'component_function': {
     \   'fugitive': 'LightLineFugitive',
     \   'filename': 'LightLineFilename',
     \   'fileformat': 'LightLineFileformat',
     \   'filetype': 'LightLineFiletype',
     \   'fileencoding': 'LightLineFileencoding',
     \   'mode': 'LightLineMode',
     \   'ctrlpmark': 'CtrlPMark',
     \ },
     \ 'component_expand': {
     \   'syntastic': 'SyntasticStatuslineFlag',
     \ },
     \ 'component_type': {
     \   'syntastic': 'error',
     \ },
     \ 'subseparator': { 'left': '|', 'right': '|' }
     \ }
function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

"==========================================
" alias
"==========================================
:command Tr NERDTreeTabsToggle

