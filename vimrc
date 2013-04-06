
" -----------------------
" View
" -----------------------
colorscheme desert
set modeline
set number       "行番号表示
set ruler        "ルーラー表示
set title        "ウィンドウタイトルを変更
"set visualbell   "visual bellの使用
set scrolloff=5

" -------------------
" Language
" -------------------
" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif

"改行コードの設定
set fileformat=unix

if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'sjis', 'euc-jp') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'sjis', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',sjis'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\)$'
      set fileencodings+=sjis
      set fileencodings-=euc-jp
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif

set fileencoding=utf-8
set fileencodings=utf-8

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  "autocmd BufReadPost * call AU_ReCheck_FENC()
endif

" 改行コードの自動認識
set fileformats=unix,dos,mac

" -------------------
" Search
" -------------------
set incsearch  "インクリメンタルサーチ
set ignorecase "大文字小文字無視
set smartcase  "大文字で開始したら大文字小文字区別
set wrapscan   "最後まで検索したら最初に戻る
set hlsearch   "検索結果をハイライト

"-------------------------------------------------------------------------------
" インデント Indent
"-------------------------------------------------------------------------------
" softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
set tabstop=4
set shiftwidth=4
set softtabstop=0
"インデントはタブではなくスペースで
set expandtab

" -------------------
 " Special `Key
 " -------------------
set list
set listchars=tab:>.,trail:_,extends:>,precedes:< " 不可視文字の表示形式
highlight SpecialKey ctermfg=darkgray
augroup highlightIdegraphicSpace
    autocmd!
    autocmd ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
    autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

" -------------------
" Input
" -------------------
set nocompatible
"バックスペースキーで削除できるものを指定
set backspace=indent,eol,start
set formatoptions+=mM          "整形オプションにマルチバイト追加
"新しい行を開始したとき、新しい行のインデントを現在行と同じくする。
set autoindent
" 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set smartindent

" -------------------
" Command
" -------------------
set wildmenu               " コマンド補完を強化
set wildmode=longest,list,full     " リスト表示，最長マッチ
"set completeopt=menu,preview,menuone
set wildchar=<tab>         " コマンド補完を開始するキー
set complete+=k            " 補完に辞書ファイル追加

" -------------------
" Programming
" -------------------
set showmatch "対応する括弧を強調表示
set cindent   "Cのインデント
"折りたたみ
"set foldmethod=marker
set foldmethod=syntax
set grepprg=internal "内蔵grep
augroup grepopen
    autocmd!
    autocmd QuickfixCmdPost vimgrep cw
augroup END

" -------------------
" Mouse
" -------------------
" ターミナルでマウスを使用できるようにする
"set mouse=a
"set guioptions+=a
"set ttymouse=xterm2

" -------------------
" Backup
" -------------------
"set autowrite " ファイル切替時に自動保存
"set hidden " 保存しないで他のファイルを表示
"set backup "バックアップ
"バックアップ取らない
set nobackup
"set backupdir=$HOME/.vimback "バックアップディレクトリ
"set directory=$HOME/.vimtmp
set history=10000  "ヒストリ件数
"set updatetime=500
"set viminfo="" ".viminfoファイルの設定
let g:svbfre = '.\+'
augroup CursorHold
    autocmd!
    autocmd CursorHold * call NewUpdate()
augroup END

" -------------------
" Status Line
" -------------------
set showcmd      "ステータスラインにコマンドを表示
"ステータスラインを2行にし、ファイルエンコーディングなどを表示
set laststatus=2
set statusline=[%L]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L
"set statusline=%<%f\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v\ %l/%L
"set statusline=%m%h%r%f\ #%n\ (%05l/%05L)\ \ [%{&fenc}]

" -------------------
" Window
" -------------------
set splitright "Window Split時に新Windowを右に表示
set splitbelow "Window Split時に新Window下をに表示

" -------------------
" Dictionary
" -------------------
set dictionary=/usr/share/dict/words

" -------------------
" File Type
" -------------------
syntax on "シンタックスハイライト
augroup syntax
    autocmd!
"    autocmd FileType perl call PerlType()
augroup END
filetype indent on "ファイルタイプによるインデントを行う
filetype plugin on "ファイルタイプによるプラグインを使う
augroup bufcmd
    autocmd!
    autocmd BufNewFile * silent! 0r $VIMHOME/templates/%:e.tpl
    autocmd BufEnter * execute ":lcd " . expand("%:p:h")
augroup END



"□とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif


"" 全角スペースや文末のタブ、スペースがあればハイライト
highlight ZenkakuSpace cterm=underline ctermfg=green ctermbg=red
"match ZenkakuSpace /　\|\( \|   \)\+$/
match ZenkakuSpace /　/



"アクティブなステータスラインの色
highlight StatusLine term=NONE guifg=#dca3a3 cterm=NONE ctermfg=black ctermbg=3
" 非アクティブなステータスラインの色
highlight StatusLineNC gui=NONE guifg=Black guibg=Green cterm=NONE ctermfg=white ctermbg=gray

highlight MatchParen term=standout ctermbg=LightGrey ctermfg=Black guibg=LightGrey guifg=Black

highlight Folded term=bold ctermfg=5 ctermbg=0
highlight DiffText term=bold ctermfg=5 ctermbg=0
highlight FoldColumn term=bold ctermfg=5 ctermbg=0
"コメントの色
highlight Comment ctermfg=darkgray


autocmd FileType php abbr <? <?php
autocmd FileType php abbr <?php= <?php echo

" 文字列中のHTMLをハイライトする
let php_htmlInStrings=1

let php_folding=1

" 対応する括弧表示は邪魔
let loaded_matchparen = 1


"ヘルプの日本語化
"helptags $HOME/.vim/doc

" php-doc
"source ~/.vim/plugin/php-doc.vim
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>

" cocoavim
"source ~/.vim/plugin/cocoa.vim



" -------------------
" キーバインド
" -------------------

"入力後括弧内にカーソルが自動で移動する
"imap {} {}<Left>
"imap [] []<Left>
"imap () ()<Left>
"imap "" ""<Left>
"imap '' ''<Left>
"imap <> <><Left>
"
"Ctrl+でタブ切り替え
map <C-Tab> gt
map <C-S-Tab> gT

" モード切替時にIMEを自動オフ
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>


" -------------------
" Vundle
" -------------------
set nocompatible
filetype off

set rtp+=~/.vim/vundle.git/
call vundle#rc()
"Bundle...は使用するプラグインを書く。詳細はguthubのREADMEが詳しい。
Bundle 'Shougo/neocomplcache'
"Bundle 'Shougo/unite.vim'
Bundle 'thinca/vim-ref'
Bundle 'thinca/vim-quickrun'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'YankRing.vim'

filetype plugin indent on


