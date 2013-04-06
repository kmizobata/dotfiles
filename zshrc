#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.

ZSH=$HOME/.zsh

# Load all of the config files in ~/oh-my-zsh that end in .zsh
# TIP: Add files you don't want in git to .gitignore
for config_file ($ZSH/libs/*.zsh); do
    source $config_file
done

##======#
## LANG #
#======##
export LANG=ja_JP.UTF-8
case ${UID} in
0)
    LANG=C
        ;;
        esac

##=========#
## PROMPT ##
#=========##
# 色付プロンプトの設定
autoload colors
colors

setopt transient_rprompt # コマンドを実行するときに右プロンプトを消す。他の端末等にコピペするときに便利。

#プロンプトの設定 (rootと一般ユーザでプロンプトを分ける)
# PROMPT  : 通常プロンプト
# PROMPT2 : 複数行入力時のプロンプト
# SPROMPT : 入力ミスを確認する場合に表示されるプロンプト
# RPROMPT : 右プロンプト
local royal=$'%{\e[1;218m%}'
case ${UID} in
0)
  PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
  PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[yellow]}%}correct:%R -> %r [n y a e]? %{${reset_color}%}%b"
  ;;
*)
  PROMPT="%{${fg[magenta]}%}[%D %*][%n]$ %{${reset_color}%}"
  PROMPT2="%{${fg[green]}%}%_%%%{${reset_color}%} "
  SPROMPT="%{${fg[yellow]}%}correct:%R -> %r [n y a e]? %{${reset_color}%}"
  ;;
esac
# リモートの場合は、先頭にHOSTを追加する
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
# 右プロンプトにカレントディレクトリを表示
RPROMPT="%{${fg[cyan]}%}[%~]%{${reset_color}%}"




#ディレクトリに色を付ける
#環境変数LS_COLORSで使う対象のうち代表的なもの
#di: ディレクトリ
#ln: シンボリックリンク
#so: ソケットファイル
#pi: FIFOファイル
#ex: 実行ファイル
#bd: ブロックスペシャルファイル
#cd: キャラクタスペシャルファイル
#su: setuidつき実行ファイル
#sg: setgidつき実行ファイル
#tw: スティッキビットありother書き込み権限つきディレクトリ
#ow: スティッキビットなしother書き込み権限つきディレクトリ

case "${TERM}" in
    screen)
        TERM=xterm
        ;;
esac

case "${TERM}" in
    xterm|xterm-color)
        export LSCOLORS=exfxcxdxbxegedabagacad
        export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        ;;
    kterm-color)
        stty erase '^H'
        export LSCOLORS=exfxcxdxbxegedabagacad
        export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        ;;
    kterm)
        # set BackSpace control character
        stty erase '^H'
        ;;
    cons25)
        unset LANG
        export LSCOLORS=ExFxCxdxBxegedabagacad
        export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30'
        zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
        ;;
    jfbterm-color)
        export LSCOLORS=gxFxCxdxBxegedabagacad
        export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
        ;;
esac

# set terminal title including current directory
# ターミナルのタイトルに「ユーザ@ホスト:カレントディレクトリ」を表示させる設定
#
case "${TERM}" in
    xterm|xterm-color|kterm|kterm-color)
        precmd() {
            echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
        }
esac

# lsコマンドの補完候補にも色付き表示
#eval `dircolors`
# kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
# sudoも補完の対象
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin


##=================#
## File Operation ##
#=================##
fpath=($ZSH/functions $ZSH/completions $fpath)
autoload -U compinit
compinit

 # ディレクトリ名を入力するだけでカレントディレクトリを変更できる。
setopt auto_cd

# 移動したディレクトリを記録しておくと、いざというときに便利
# cd -[ここでタブキーを押す]
# これまでに移動したディレクトリが一覧表示される
setopt auto_pushd

# コマンドのスペルミスを指摘して予想される正しいコマンドを提示してくれる。このときのプロンプトがSPROMPT。
setopt correct

setopt magic_equal_subst # = 以降でも補完できるようにする( --prefix=/usr 等の場合)
setopt nobeep        # 補完候補表示時などにビープ音をならないように設定
setopt nolistbeep        # 補完候補表示時などにビープ音をならないように設定
setopt prompt_subst      # エスケープシーケンスを通すオプション

## 同じディレクトリを pushd しない
## ディレクトリスタックに重複する物は古い方を削除
setopt pushd_ignore_dups

# compacked complete list display
# 補完候補をつめて表示
setopt list_packed

setopt noautoremoveslash # パスの最後に付くスラッシュを自動的に削除しない

# ファイル、ディレクトリの新規作成時のパーミッションを設定
# 新規作成ファイルのパーミッションは 664 、新規作成のディレクトリは 755 になるので、 同グループのユーザの読み書きが可能になる。
#umask 002

# zsh editor
autoload zed

export SHELL=/bin/zsh
export EDITOR="vim"
export SVN_EDITOR="vim"

export TERM=xterm-256color screen

export PAGER='/usr/bin/less -irs'
