"" texのconcealを無効化（#^ω^）
let g:tex_conceal=''
" 背景透過
augroup TransparentBG
  	autocmd!
	autocmd Colorscheme * highlight Normal ctermbg=none
	autocmd Colorscheme * highlight NonText ctermbg=none
	autocmd Colorscheme * highlight LineNr ctermbg=none
	autocmd Colorscheme * highlight Folded ctermbg=none
	autocmd Colorscheme * highlight EndOfBuffer ctermbg=none 
augroup END

tnoremap <C-j> <C-\><C-n>
tnoremap <C-[> <C-\><C-n>
set inccommand=split

"set guicursor=a:blinkon0    " カーソルの点滅なし
set guicursor=
set linespace=1             " 行間隔
" set columns=180             " ウインドウ幅
" set lines=57                " ウインドウ高
set cmdheight=2             " コマンドライン幅
set guioptions-=T           " ツールバー消去
set guioptions-=m           " メニューバー非表示
set display=lastline        " 長い行を省略せずに表示する
set pumheight=10            " 補完リストの高さ
set number
set laststatus=2            " Powerline のため
"set notitle                 " タイトルなし
"set shortmess+=I            " タイトルなし

" set iminsert=0 imsearch=0                     " 挿入モード・検索モードでのデフォルトのIME状態設定
set expandtab                                 " タブ入力時に自動的にスペースに変える
set tabstop=2                                 " 1タブの幅
set softtabstop=2                             " 1タブ当たりの半角スペースの個数 (通常入力時)
set shiftwidth=2                              " 1タブ当たりの半角スペースの個数 (コマンドや自動インデント)
"set clipboard=unnamed                         " クリップボード
set autoindent                                " 自動的にインデントする (noautoindent:インデントしない)
set clipboard=unnamed,unnamedplus             " firefox, xterm への S-Insert でのペーストが出来た (ginit.vim あり)
"set backspace=indent,eol,start                " バックスペースでインデントや改行を削除できるようにする
set showmatch
set matchtime=1                     " 入力時対応する括弧に飛ぶ。表示時間 ＝ 0.1 * matchtime (秒)
set wildmenu                                  " コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set nobackup                                  " バックアップファイルを作成しない
set noswapfile
set viminfo=
"set noundofile                                " undoファイル (*.un~) を作成しない
" set undodir=$HOME/.config/nvim/undo
" Y を y$ と同じにする。(ノーマルモード・再割り当て無し) 
nnoremap Y y$
set scrolloff=5                               " スクロールする時に下が見えるようにする
set wildmenu                                  " コマンドライン補完するときに強化されたものを使う
set virtualedit=block

"検索語が画面の真ん中に来るようにする
nmap n nzz 
nmap N Nzz 
nmap * *zz 
nmap # #zz 
nmap g* g*zz 
nmap g# g#zz

inoremap <silent> jj <ESC>

" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd

" 見た目系
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>


inoremap <C-f> <Right>
inoremap <C-b> <Left>


" call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0}) 
" call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1}) 

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/m/.config/nvim/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/m/.config/nvim')
  call dein#begin('/home/m/.config/nvim')

  " Let dein manage dein
  " Required:
  call dein#add('/home/m/.config/nvim/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  " call dein#add('Shougo/neosnippet.vim')
  " call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })

  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0}) 
  call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1}) 
  

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"


"End dein Scripts-------------------------

