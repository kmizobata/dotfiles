
###################################
# Keybind configuration
# キーバインド設定
###################################
#emacs風のキーバインド
#Ctrl-A   : 行頭へジャンプ
#Ctrl-E   : 行末へジャンプ

#Ctrl-L   : クリアスクリーン

#Ctrl-U   : 一行削除
#Ctrl-B   : ←キー
#Ctrl-F   : →キー
#Ctrl-P   : ↑キー(履歴を戻る)
#Ctrl-N   : ↓キー(履歴を進む)
#Ctrl-D   : Deleteキー
#Ctrl-H   : BackSpaceキー
bindkey -e
bindkey "^[[1~" beginning-of-line # Home gets to line head
bindkey "^[[4~" end-of-line # End gets to line end
bindkey "^[[3~" delete-char # Del
# Delete,Home,Endがおかしな動きをするときのおまじない
bindkey '^[[3~' backward-delete-char

# 履歴からsearchを矢印キーで行う
autoload history-search-end

#複数行の編集には↓↑←→を使う
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

#コマンド履歴の検索機能はCtrl-PとCtrl-Nに割り当て
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# reverse menu completion binded to Shift-Tab
bindkey "\e[Z" reverse-menu-complete

# インクリメンタルサーチの設定
bindkey "^R" history-incremental-search-backward

