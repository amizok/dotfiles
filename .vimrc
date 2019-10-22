"
" dein.vim
"

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

"
" General settings
"

" 文字コード
set encoding=utf-8
" ターミナルにファイル名を表示
set title
" 行番号を表示する
set number
" 不可視文字を表示
set list
" 不可視文字の表示記号指定
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
" 対応する括弧を強調表示
set showmatch
" 構文毎に文字色を変化させる
syntax on
" bashのシンタックスもきれいに
let g:is_bash = 1
" 256色を使う
set t_Co=256
" ヘルプを画面いっぱいに開く
set helpheight=999

set synmaxcol=500
"-------------------------------------------------------------------------------
" 検索系に関する設定:

" 検索結果をハイライト
set hlsearch
" 大文字小文字を区別しないで検索
set ignorecase
" 小文字の時は区別しない
set smartcase
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"-------------------------------------------------------------------------------
" 編集に関する設定:

" 貼り付け時に余計なインデントが効かないようにする
"set paste
" タブの画面上での幅
set tabstop=4
" 自動インデントでずれる幅
set shiftwidth=4
" タブの代わりに空白文字を指定する
set expandtab
" 新しい行のインデントを現在行と同じにする
set autoindent
" 編集で <Tab> の幅として使用する空白の数
set softtabstop=4
" 新しい行を作ったときに自動インデントを行う
set smartindent
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

set ambiwidth=double
"-------------------------------------------------------------------------------
" ステータスに関する設定:

" ステータス行を常に表示
set laststatus=2
" メッセージ表示欄を2行確保
set cmdheight=1
" ファイル情報表示
set statusline=%<[%n]%F%=\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}\ %l,%c\ %P

"-------------------------------------------------------------------------------
" ファイル操作に関する設定:

" バックアップファイル {{{
"" 有効化
set backup
"" 出力先
set backupdir=~/.vim/.backup
" スワップファイル
"" 有効化
set swapfile
"" 出力先
set directory=~/.vim/.swap
" UNDOファイル
"" 有効化
set undofile
"" 出力先
set undodir=~/.vim/.undo
" }}}

"-------------------------------------------------------------------------------
" その他
set backspace=indent,eol,start " deleteキーが効かない対応
set clipboard+=unnamed         " ヤンクをクリップボードへ送り込む
set ttm=0                      " キーの反応を早く
set visualbell t_vb=           " Beep音を消す

"-------------------------------------------------------------------------------
" マッピング

nnoremap <S-h> ^
nnoremap <S-j> }
nnoremap <S-k> {
nnoremap <S-l> $
nnoremap m %
nnoremap <Space>o  :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <Space>O  :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>

nnoremap s <Nop>
" ウィンドウの切り替え
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
" ウィンドウの移動
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
" タグの作成
nnoremap st :<C-u>tabnew<CR>
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap Y y$
nnoremap sf :<C-u>copen<CR>
nnoremap sc :<C-u>cclose<CR>
" 折りたたみ
set foldmethod=marker
au FileType vim setlocal foldmethod=marker

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

"-------------------------------------------------------------------------------
" Change colourscheme when diffing
"-------------------------------------------------------------------------------
fun! SetDiffColors()
  hi DiffAdd    cterm=none ctermbg=22    ctermfg=Green
  hi DiffDelete cterm=none ctermfg=7     ctermbg=52
  hi DiffChange cterm=none ctermfg=white ctermbg=none
  hi DiffText   cterm=none ctermfg=Green ctermbg=22
endfun
autocmd FilterWritePre * call SetDiffColors()


"-------------------------------------------------------------------------------
" 各プラグインに関する設定:
"-------------------------------------------------------------------------------

"--------------------------------
" GNU GLOBAL(gtags)
"--------------------------------
"" 検索結果Windowを閉じる
" nmap <C-q> <C-w><C-w><C-w>q
"" ソースコードの grep
nmap <C-g> :Gtags -g
"" このファイルの関数一覧
nmap <C-l> :Gtags -f %<CR>
"" カーソル以下の定義元を探す
nmap <C-j> :GtagsCursor<CR>
"" カーソル以下の使用箇所を探す
nmap <C-k> :Gtags -r <C-r><C-w><CR>
"" 次の検索結果へジャンプする
nmap <C-n> :cn<CR>
"" 前の検索結果へジャンプする
nmap <C-p> :cp<CR>

"--------------------------------
" fzf
"--------------------------------
nnoremap <silent> <Space>f  :<C-u>GFiles<CR>
nnoremap <silent> <Space>b  :<C-u>Buffers<CR>

"--------------------------------
" vim-fugitive
"--------------------------------
"" grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow
"" ステータス行に現在のgitブランチを表示する
set statusline+=%{fugitive#statusline()}

"--------------------------------
" vim-indent-guides
"--------------------------------
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=237

"--------------------------------
" accelerated-jk
"--------------------------------
"" j/kによる移動を速くする
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

"--------------------------------
" lightline.vim
"--------------------------------
if filereadable(expand('~/dotfiles/.vim/plugin/lightline.vim'))
    source ~/dotfiles/.vim/plugin/lightline.vim
endif

"--------------------------------
" vdebug
"--------------------------------
if filereadable(expand('~/dotfiles/.vim/plugin/vdebug.vim'))
    source ~/dotfiles/.vim/plugin/vdebug.vim
endif

"--------------------------------
" NERDTree
"--------------------------------
" .ファイルの表示（1: 表示）
let NERDTreeShowHidden=0
" ブックマークを表示 (1:表示)
let g:NERDTreeShowBookmarks=1
" 表示・非表示切り替え
nmap <silent> <C-e> :NERDTreeTabsToggle<CR>

"-------------------------------------------------------------------------------
" PHP用設定
" :makeでPHP構文チェック
au FileType php setlocal makeprg=php\ -l\ %
au FileType php setlocal errorformat=%m\ in\ %f\ on\ line\ %l

