
"バックアップ取らない
set nobackup

set nocompatible
filetype off

"vundleのディレクトリ
set rtp+=~/.vim/vundle.git/
call vundle#rc()
"Bundle...は使用するプラグインを書く。詳細はguthubのREADMEが詳しい。
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'thinca/vim-ref'
Bundle 'thinca/vim-quickrun'
filetype plugin indent on
