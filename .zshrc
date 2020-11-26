#
# zshrc
#

# ------------------------------------------------------------------------
# Exports
# ------------------------------------------------------------------------
export LANG=ja_JP.UTF-8
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:$PATH"
export PATH="$PATH:$HOME/.anyenv/envs/nodenv/versions/10.15.3/bin/"
export GREP_OPTIONS='--color=auto'
export EDITOR='vim'
export TERM="screen-256color"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"


# ------------------------------------------------------------------------
# Plugin Manager
# ------------------------------------------------------------------------
# zplug
if [ ! -e ~/.zplug/init.zsh ]; then
    echo "downloading zplug."
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
    echo "done."
fi
source ~/.zplug/init.zsh

# プラグインを定義
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting'

# Install plugins if there are plugins that have not been installed
#if ! zplug check --verbose; then
if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load


# ------------------------------------------------------------------------
# Basic setting
# ------------------------------------------------------------------------
autoload -Uz colors && colors # 色を使用出来るようにする
setopt print_eight_bit        # 日本語ファイル名を表示可能にする
setopt no_beep                # beep を無効にする
setopt nonomatch              # メタ文字を回避
setopt no_flow_control        # フローコントロールを無効にする
setopt interactive_comments   # '#' 以降をコメントとして扱う
setopt extended_glob          # 高機能なワイルドカード展開を使用する
setopt hist_verify            # `!!`を実行したときにいきなり実行せずコマンドを見せる
setopt pushd_ignore_dups      # 重複したディレクトリを追加しない


# ------------------------------------------------------------------------
# History setting
# ------------------------------------------------------------------------
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_all_dups # 重複するコマンドは古い法を削除する
setopt share_history        # 異なるウィンドウでコマンドヒストリを共有する
setopt hist_no_store        # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks   # 余分な空白は詰めて記録
setopt hist_ignore_space    # スペースから始まるコマンド行はヒストリに残さない


# ------------------------------------------------------------------------
# Key bind
# ------------------------------------------------------------------------
bindkey -e # emacs 風キーバインドにする
# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars ' /=;@:{}[]()<>,|.'
zstyle ':zle:*' word-style unspecified
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'


# ------------------------------------------------------------------------
# Prompt
# ------------------------------------------------------------------------
# 2行表示
PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
%# "


# ------------------------------------------------------------------------
# Completions
# ------------------------------------------------------------------------
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


# ------------------------------------------------------------------------
# Alias
# ------------------------------------------------------------------------
alias mkdir='mkdir -p'
alias tree='tree -NC'
alias sudo='sudo ' # sudo の後のコマンドでエイリアスを有効にする
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

# OS 別の設定
case ${OSTYPE} in
    darwin*)
        # Mac
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        # Linux
        alias ls='ls -F --color=auto'
        ;;
esac

# Global Alias ------
alias -g L='| less'
alias -g G='| grep'

# ------------------------------------------------------------------------
# profiling
# ------------------------------------------------------------------------
if (which zprof > /dev/null) ;then
    zprof | less
fi


# ------------------------------------------------------------------------
# Pseudo zlogin on each login
# ------------------------------------------------------------------------
# echo "${fg[${ZSH_HOST_COLOR}]}$(uptime)"
# echo "Kernel: $(uname -r) ($(uname -v))${reset_color}"
# echo ""
# [ -f /usr/bin/fortune ] && fortune "${ZSH_FORTUNE_ARG:-}" && echo ""


# ------------------------------------------------------------------------
# tmux
# ------------------------------------------------------------------------
if [[ ! -n $TMUX && $- == *l* ]]; then
    # get the IDs
    ID="`tmux list-sessions`"
    if [[ -z "$ID" ]]; then
        tmux new-session
    fi

    create_new_session="Create New Session"
    ID="$ID\n${create_new_session}:"
    ID="`echo $ID | fzf | cut -d: -f1`"
    if [[ "$ID" = "${create_new_session}" ]]; then
        tmux new-session
    elif [[ -n "$ID" ]]; then
        tmux attach-session -t "$ID"
    else
        : # Start terminal normally
    fi
fi


# ------------------------------------------------------------------------
# anyenv for homebrew
# ------------------------------------------------------------------------
eval "$(anyenv init -)"

# ------------------------------------------------------------------------
# fzf functions
# ------------------------------------------------------------------------
fzf_ssh_inline() {
  local found
  found="$(grep "^Host" $HOME/.ssh/*config | grep -v \* | fzf --exact --no-sort --reverse)"

  if [[ $? -ne 0 ]] || [[ "$found" =~ "^[:blank:]*$" ]]; then
    return 1
  fi

  BUFFER="ssh $(echo "$found" | awk '{print $2}')"
  zle clear-screen
  zle vi-end-of-line
}

zle -N fzf_ssh_inline

# キーバインド (ここでは Ctrl+T として設定)
bindkey '^T' fzf_ssh_inline

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;91m") \
        LESS_TERMCAP_md=$(printf "\e[1;91m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

