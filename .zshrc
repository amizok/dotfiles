########################################
# 環境変数
export LANG=ja_JP.UTF-8
export PATH="/usr/local/sbin:$PATH"

########################################
# プラグイン管理 zplug
source ~/.zplug/init.zsh

# (1) プラグインを定義する
# zplug ''
#zplug 'zsh-users/zsh-autosuggestions'
#zplug 'zsh-users/zsh-completions'
#zplug 'zsh-users/zsh-syntax-highlighting'
#zplug 'b4b4r07/enhancd'
## fzf-bin にホスティングされているので注意
## またファイル名が fzf-bin となっているので file:fzf としてリネームする
#zplug "junegunn/fzf-bin", as:command, from:gh-r, file:fzf
#
## ついでに tmux 用の拡張も入れるといい
#zplug "junegunn/fzf", as:command, of:bin/fzf-tmux
## zplug ''
#
## Install plugins if there are plugins that have not been installed
#if ! zplug check --verbose; then
#    printf "Install? [y/N]: "
#    if read -q; then
#        echo; zplug install
#    fi
#fi
#
## Then, source plugins and add commands to $PATH
#zplug load --verbose

########################################

# 色を使用出来るようにする
autoload -Uz colors
colors

# emacs 風キーバインドにする
bindkey -e

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# プロンプト
# 1行表示
# PROMPT="%~ %# "
# 2行表示
PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
%# "

#
# Editors
#
export EDITOR='vim'
export VISUAL='vim'

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified


########################################
# 補完
#for zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)# 補完機能を有効にする

autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
# beep を無効にする
setopt no_beep
# フローコントロールを無効にする
setopt no_flow_control
# '#' 以降をコメントとして扱う
setopt interactive_comments
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups
# 同時に起動したzshの間でヒストリを共有する
setopt share_history
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# 高機能なワイルドカード展開を使用する
setopt extended_glob
# メタ文字を回避
setopt nonomatch

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward


########################################
# エイリアス

alias mkdir='mkdir -p'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

alias vi='vim'
alias updatedb='sudo /usr/libexec/locate.updatedb'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac

## tmux の自動立ち上げ
#function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
#function is_osx() { [[ $OSTYPE == darwin* ]]; }
#function is_screen_running() { [ ! -z "$STY" ]; }
#function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
#function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
#function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
#function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }
#
#function tmux_automatically_attach_session()
#{
#    if is_screen_or_tmux_running; then
#        ! is_exists 'tmux' && return 1
#
#        if is_tmux_runnning; then
#            echo "${fg_bold[blue]} _____ __  __ _   ___  __ ${reset_color}"
#            echo "${fg_bold[blue]}|_   _|  \/  | | | \ \/ / ${reset_color}"
#            echo "${fg_bold[blue]}  | | | |\/| | | | |\  /  ${reset_color}"
#            echo "${fg_bold[blue]}  | | | |  | | |_| |/  \  ${reset_color}"
#            echo "${fg_bold[blue]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
#        elif is_screen_running; then
#            echo "This is on screen."
#        fi
#    else
#        if shell_has_started_interactively && ! is_ssh_running; then
#            if ! is_exists 'tmux'; then
#                echo 'Error: tmux command not found' 2>&1
#                return 1
#            fi
#
#            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
#                # detached session exists
#                tmux list-sessions
#                echo -n "Tmux: attach? (y/N/num) "
#                read
#                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
#                    tmux attach-session
#                    if [ $? -eq 0 ]; then
#                        echo "$(tmux -V) attached session"
#                        return 0
#                    fi
#                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
#                    tmux attach -t "$REPLY"
#                    if [ $? -eq 0 ]; then
#                        echo "$(tmux -V) attached session"
#                        return 0
#                    fi
#                fi
#            fi
#
#            if is_osx && is_exists 'reattach-to-user-namespace'; then
#                # on OS X force tmux's default command
#                # to spawn a shell in the user's namespace
#                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
#                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
#            else
#                tmux new-session && echo "tmux created new session"
#            fi
#        fi
#    fi
#}
#tmux_automatically_attach_session
#
