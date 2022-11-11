
-- let $LANG='en_US.UTF-8'
-- texのconcealを無効化（#^ω^）
vim.g.tex_conceal = ''

vim.o.signcolumn = 'yes'

vim.api.nvim_set_keymap('n', 'Y', 'y$', {noremap = true})

vim.api.nvim_set_keymap('t', '<C-j>', '<C-\\><C-n>', {noremap = true})
vim.api.nvim_set_keymap('t', '<C-[>', '<C-\\><C-n>', {noremap = true})

-- nmap <C-j> :bp<CR>
-- nmap <C-k> :bn<CR>

vim.o.inccommand = 'split'
vim.o.cursorline = true

vim.o.linespace = 1
vim.o.cmdheight=2
vim.o.display='lastline'
vim.o.pumheight=10
vim.o.number = true
vim.o.laststatus=2

vim.o.guifont='DroidSansMono Nerd Font'
vim.o.termguicolors=true

-- set iminsert=0 imsearch=0
vim.o.expandtab = true
vim.o.tabstop=2
vim.o.softtabstop=2
vim.o.shiftwidth=2
vim.o.autoindent = true
vim.o.clipboard = vim.o.clipboard .. 'unnamedplus'
vim.o.showmatch = true
vim.o.matchtime=1
vim.o.backup = false
vim.o.swapfile = false
vim.o.viminfo=''
vim.o.scrolloff=5
vim.o.wildmenu = true
vim.o.virtualedit='block'

-- 検索語が画面の真ん中に来るようにする
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', '#', '#zz')
vim.keymap.set('n', 'g*', 'g*zz')
vim.keymap.set('n', 'g#', 'g#zz')

vim.g.mapleader = '\\<Space>'

vim.api.nvim_set_keymap('i', 'jj', '<ESC>', {noremap = true, silent = true})

-- 編集中のファイルが変更されたら自動で読み直す
vim.o.autoread = true
-- バッファが編集中でもその他のファイルを開けるように
vim.o.hidden = true
-- 入力中のコマンドをステータスに表示する
vim.o.showcmd = true
-- 行末の1文字先までカーソルを移動できる
vim.o.virtualedit = 'onemore'
-- スマートインデント
vim.o.smartindent = true
-- ビープ音を可視化
vim.o.visualbell = true
-- コマンドラインの補完
vim.o.wildmode = 'list:longest'

-- 表示行単位での移動
vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true})
vim.api.nvim_set_keymap('x', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('x', 'k', 'gk', {noremap = true})


-- 検索系
-- 検索文字列が小文字の場合は大文字小文字を区別しない
vim.o.ignorecase = true
-- 検索文字列に大文字が含まれている場合は大文字小文字を区別
vim.o.smartcase = true
-- 検索文字列入力時に順次対象文字列にヒットさせる
vim.o.incsearch = true
-- 検索時に最後まで行ったら最初に戻る
vim.o.wrapscan = true
-- 検索語をハイライト表示する
vim.o.hlsearch = true

vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>')

vim.api.nvim_set_keymap('i', '<C-f>', '<Right>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-b>', '<Left>', {noremap = true})

vim.o.completeopt='menuone'

-- vscode 用の設定
  if vim.g.vscode then
    -- comment
    vim.keymap.set('x', 'gc', '<Plug>VSCodeCommentary')
    vim.keymap.set('n', 'gc', '<Plug>VSCodeCommentary')
    vim.keymap.set('o', 'gc', '<Plug>VSCodeCommentary')
    vim.keymap.set('n', 'gcc', '<Plug>VSCodeCommentaryLine')

    -- tab 移動
    vim.keymap.set('n', '<C-h>', ":call VSCodeNotify('workbench.action.previousEditor')<cr>")
    vim.keymap.set('n', '<C-l>', ":call VSCodeNotify('workbench.action.nextEditor')<cr>")

    vim.keymap.set('n', '<Space>rn', ":call VSCodeNotify('editor.action.rename')<cr>")
    vim.keymap.set('n', '<Space>gd', ":call VSCodeNotify('editor.action.revealDefinition')<cr>")
    vim.keymap.set('n', '<Space>rn', ":call VSCodeNotify('editor.action.peekDefinition')<cr>")
  end

vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]
require'plugins'

